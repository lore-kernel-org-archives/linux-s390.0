Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAC3C1F4B;
	Wed,  3 Jun 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527352; cv=none; b=M7x797S1bSOa//eDlLO9iMxLzYOMfzrq4OW2hdsGpBuJCF/7fuww4LzTiAfHnFrfIsQ6tNTtxQc7zUjKA331kwyLnm67HL5vR8o8l8AMPfFGr09O5z0gaLDYmnXhgEUhPdj5SwfzVXcEoWRG8jnVPUi3Xih0AlWSMmUYN+t60c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527352; c=relaxed/simple;
	bh=monqEsI2S4j/XL8McehdUDy1eGDnD5qk3b3z0uNDJEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3A8VrCEdq6aeGiew/ZAQdhceF7OOmceM3KHiXHJxoFQHBxU/dEar67mj1ukPHGStb8IB54RjSwV+o58GxvEYTMyX1866+Oz5Z4Nt9DnUEtlEPYauXH2kDtpQzAe1Df4iHidldHhbpOjylfGwq/45qvqyw6NzR6ZlpUHfEvB53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtGjnhM9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtGjnhM9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=monqEsI2S4j/XL8McehdUDy1eGDnD5qk3b3z0uNDJEs=; b=AtGjnhM9EYe4bbEq2mPMTCAihV
	jCCbQJ6hoJB9VbOSgVP+bYqxQVaXkFb61SHOr9Gmp5la5sxGAt2VtYR41n4rs7lWrm5mCCN1fe59F
	4H/Xkid25KaKxRRZwSM7BNvdbR9DGETkAqLVxdrGph00kSwqg65rsboGnewYJ19R3Q3HopCowGOar
	5tfM7Gw9BYwkHQGQ3ibQZCVeW4PHFMYbB2s9/Jh8SgYMBIXGyDcP+tTETNo9DfoHGI6AAmlyxNoEy
	n4/WSeQzI8I9uq0YmE0ZqDYIRKWNrMDdX/qRyOAXb1iYexzBsXUCPW96DN3oDW4AvzTI0eKxqrSaF
	/TFkR5BA==;
Received: from [2001:8b0:10b:5:1f56:7574:811c:9661] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUuUj-00000004gci-2RQV;
	Wed, 03 Jun 2026 22:55:30 +0000
Message-ID: <41c6f1f85fdfae7658447ca0bd4de168666610e3.camel@infradead.org>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, Wen Gu
 <guwen@linux.alibaba.com>, 	tglx@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, 	pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 	jstultz@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, 	daniel.lezcano@kernel.org,
 sboyd@kernel.org, vladimir.oltean@nxp.com, 	wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, 
	vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com, 
	nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, 	bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, 	imx@lists.linux.dev,
 linux-s390@vger.kernel.org, dust.li@linux.alibaba.com, 
	xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com, 
	taniya.das@oss.qualcomm.com
Date: Wed, 03 Jun 2026 23:55:29 +0100
In-Reply-To: <20260602190357.62c04d40@kernel.org>
References: <20260412084704.743482ad@kernel.org>
		<4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
		<20260412095301.4fe1fe65@kernel.org>
		<ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
		<1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
		<ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
		<3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
		<ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
		<0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
		<20260601185226.7f43fa75@kernel.org>	<ah5aGMIxA418sxoj@hoboy.vegasvil.org>
		<0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
	 <20260602190357.62c04d40@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ky+/Ct5Xag5kaMTkTGmv"
User-Agent: Evolution 3.60.3 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-ky+/Ct5Xag5kaMTkTGmv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-02 at 19:03 -0700, Jakub Kicinski wrote:
> On Tue, 02 Jun 2026 09:04:27 +0100 David Woodhouse wrote:
> > > Even though the "PTP" naming was an unfortunate choice way back when,
> > > still I'm not a big fan of moving stuff around "just because".
> > >=20
> > > But moving forward, I would suggest starting a new area for pure
> > > hardware clock devices.=C2=A0=C2=A0=C2=A0=20
> >=20
> > I think that ties relatively well to Jakub's "does it purport to know
> > real time better than the host" criterion?
> >=20
> > Although... ENA *both* purports to know real time better than the host
> > *and* does packet timestamping, and it looks like GVE is attempting to
> > do the same?
>=20
> FWIW the ENA driver as it exists upstream does not currently support
> packet timestamping. Or at least the usual terms for which I'm grepping
> do not hit anything in this driver. Only skb_tx_timestamp() which is SW
> timestamping
>=20
> Given various Google projects related to use of time / latency for
> networking I think you're right that GVE is likely the first driver
> that will straddle the boundary. For those drivers which are both NIC
> and virt we can stick to net-next, just always wait for your review?

No need to block on me unless you want to. I'll just take the things
off your hands that you actively don't want.

--=-ky+/Ct5Xag5kaMTkTGmv
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDYwMzIyNTUy
OVowLwYJKoZIhvcNAQkEMSIEIAulf+oHI/h+9Y41iVxi6iB2Tzncfg1bLq+aProeWZPHMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIANs/11Jmc4L+Z
FlUHNjcx3rhzpdz+TGPtL0ITyFDEEKdzfW/zYBkd6wgsyA4J1wvWdOVbqGzmhkv/dhV7m6Loa5Xi
Rejqon4P4u9wOjvgAJ4ydFp667n8Y1LHEIRtjfTuzu5TF8yLUNtrqRg1ANEFtKLTD/4K8wieku5Z
BAOBg1wTuBt85wzNuoDLUrfXgDJGD4zIaRFWegHl+PCYxN4bnQ94Uk6S1A7moxP1Z/uSoERsRVBG
ImegrcPW9fnv9bpJAFJ6YWAT0Ctprx1JudQFGmWGX5957suV74qn8gOFIOWf7qXgvOjsne7gdxbJ
9ctPOAXZk9doErwbWp7yMqYvKExl67krnfexp5qf8uT3YbHf1hdv+eFNT16agohEFhJXr6MQzYNm
95S96LoASTRBBvnR2pGQKT59dQ/RySHrR45XqNLUjbJdDPJv138t22Q11D++8m7Fe/Hzba7P66ER
4hTARBVFaUfiNy5LiD42+0yhIZ9ChRZSQcS+EaGff8XC3WCkzkungNPfiFHCXmtN/X50H6YaZIy0
TCXOuUKA+LjQYOH8H0JNoVC4m2YJhf5b6cWKCPgGPD+TZ//9mMUzcG9m4Os/eenWJ3cqlybawFDf
R+MAV1EXqG69sFgascMA+z6I8PvEqsSZ/V0S4e65r/F9lQpH4tcNnpMXkgjcIZUAAAAAAAA=


--=-ky+/Ct5Xag5kaMTkTGmv--
