defmodule BasicBench do
    use Benchfella
    
    setup_all do
      GenServer.start_link(ExRated, [
        {:timeout, 10_000},
        {:cleanup_rate,10_000},
        {:persistent, false},
      ], [name: :ex_rated])
    end

    after_each_bench _tid do
      ExRated.delete_bucket("my-bucket")
    end

    bench "Basic Bench" do
      ExRated.check_rate("my-bucket", 1000000, 10_000_000)
      {:ok}
    end
end
