from prefect.deployments import run_deployment


def main():
    response = run_deployment(name="hft-flow/my-first-deployment-1")
    print(response)


if __name__ == "__main__":
   main()