module ProjectTools

using LinearAlgebra, Statistics

export
    err_abs,
    err_cum,
    err_norm,
    err_max,
    compute_integration_matrix

err_abs(exact, approx) = abs.(exact - approx)
err_cum(exact, approx) = [sum(err_abs(exact[1:i], approx[1:i])) for i in 1:length(data_correct)]
err_norm(exact, approx, p) = norm(err_abs(exact, approx), p)
err_max(exact, approx)  = maximum(err_abs(exact, approx))

function compute_integration_matrix(M; integral_resolution=10)
    [compute_integration_matrix_entry(M, m, i, integral_resolution)
     for m = 0:(M-1), i = 0:M]
end

function compute_integration_matrix_entry(M, m, i, integral_resolution)
    t_array = range(m, m+1, integral_resolution) |> collect
    dt = t_array[2] - t_array[1]
    sum(prod((t-k)/(i-k) for k = 0:M if k != i)*dt for t in t_array[1:end-1])
end

end