import Link from "@docusaurus/Link";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Layout from "@theme/Layout";
import clsx from "clsx";
import React from "react";
import styles from "./index.module.css";

const FEATURES = [
	{
		title: "Lazy, not Eager.",
		description: (
			<>
				<p>Futures will not begin execution until polled or awaited, unlike Promises when begin immediately.</p>
				<p>
					Polling will execute until the next suspension point, until execution is finished. By awaiting a
					Future, it will yield the current thread until execution has completed.
				</p>
			</>
		),
	},
	{
		title: "Rusty. Rust-like.",
		description: (
			<>
				Luau Futures aim to have similar API and behavior to Rust Futures where possible, drawing inspiration
				otherwise.
			</>
		),
	},
	{
		title: "Types? Check. Typechecked.",
		description: (
			<>
				Luau Futures are strictly typed, within the type solver's restrictions.
				<div class="card__footer">
					<a class="button button--outline button--secondary button--block" href="/docs/typechecking">
						Typechecking Guide
					</a>
				</div>
			</>
		),
	},
];

function FeatureIcon({ icon }) {
	return <div className={styles["feature-icon"]}>{icon}</div>;
}

function Feature({ title, description }) {
	return (
		<div class="col margin-bottom--lg">
			<div class="card">
				<div class="card__header">
					<h2>{title}</h2>
				</div>
				<div class="card__body">{description}</div>
			</div>
		</div>
	);
}

function HomepageFeatures() {
	return (
		<div className="container">
			<div class="row">
				{FEATURES.map((props, idx) => (
					<Feature key={idx} {...props} />
				))}
			</div>
		</div>
	);
}

function HeroBanner() {
	const { siteConfig } = useDocusaurusContext();

	return (
		<div class="hero hero--primary" style={{ height: "25rem", marginBottom: "5rem" }}>
			<div class="container">
				<h1 class="hero__title" style={{ color: "var(--ifm-color-secondary)" }}>
					{siteConfig.title}
				</h1>
				<p class="hero__subtitle" style={{ color: "var(--ifm-color-secondary)" }}>
					{siteConfig.tagline}
				</p>
				<div>
					<a class="button button--secondary button--lg" style={{ marginRight: "1rem" }} href="/docs/intro">
						<span class={styles["hero-button-text"]}>Get Started</span>
					</a>
					<a
						class="button button--outline button--secondary button--lg hero-button"
						style={{ marginRight: "1rem" }}
						href="/api"
					>
						<span class={styles["hero-button-text"]}>API</span>
					</a>
				</div>
			</div>
		</div>
	);
}

export default function Homepage() {
	const { siteConfig } = useDocusaurusContext();
	return (
		<Layout title={siteConfig.title} description={siteConfig.tagline}>
			<main>
				<HeroBanner />
				<HomepageFeatures />
			</main>
		</Layout>
	);
}
