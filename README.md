# iaac
This repository is designed for **Infrastructure as Code (IaC)** testing purposes. It includes scripts and configurations to develop, test, and manage infrastructure components using Python-based tools.

## Features
- **Flask** as a core dependency for web-based application testing.
- **Development Tools**: 
  - `pytest` for automated testing.
  - `flake8` for linting and code quality assurance.

## Getting Started
### Prerequisites
- Python 3.7 or later
- `pipenv` for managing dependencies

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/DanielCarmel/iaac.git
   cd iaac
2. Install the required dependencies:
    ```bash
    pipenv install --dev

### Usage

1. Activate the development environment:
   ```bash
   pipenv shell
2. If there are Flask-based scripts, start the application:
   ```bash
   python app.py
3. Run the test suite:
   ```bash
   pytest
   
### Purpose
This repository is created solely for testing and learning purposes. It is not intended for production use.

### License
This project is not licensed for commercial use and serves as a demonstration for testing IaC concepts.