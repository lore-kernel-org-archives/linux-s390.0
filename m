Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD5393DD4;
	Fri, 27 Feb 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187976; cv=none; b=iZLhp/099kZMgF1gu2TZRdvCHRoV7HIp21Vg+sjXMcoser9fZ13J42NkCi8VGcUIdpZtTGDPn/Kc1Mj1dj7ZWRGawP4hA6+7zNmqIw/GS5xTc893yWqGnSHv5vFa4dwczm4zdaiawPU8NhpMW+UknNhmVz1J6vbpjoq0L/mK2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187976; c=relaxed/simple;
	bh=U6qsG3RCujy4VZbDK4gJJXjVt51fYC4GNNceCnOjb1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKVx5umfJwY3E2glRWCSbe32mISO1KsqGv+C23Vas6kLq9FQOXp4khTaPEvhu841a/xhkPw6EWP3C/U8sdrSU1Kx9zhzNSHHwkOl/9P/iULCdjIJxpAvf0sXD9oy0+HpVQzc3rUaa6otbptspyboZlEx+W5RIlky+OyeHvZ/juE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gXtXppNQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gXtXppNQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U6qsG3RCujy4VZbDK4gJJXjVt51fYC4GNNceCnOjb1M=; b=gXtXppNQJz4Sgw/rAH5I0a2NgA
	xuMdaYIB884cY7rWoBaGORqp4+FaeU51rCEHatNpaWjgkW0rTzb6TM0XYihONfCKlpWwV78K7kNU6
	oVf59lpBPgePIRsem0A119YQvSvCBOmJvjf2KW9ct/5BbLQ7HQNfr/l/wuoPBfbcXIGOIh/sa4nQ5
	ks4ZXvpA13KcjnZZzoXTKQ+ZW8hQaal8EkerdpmSNwjMn8qwLeaaBqXBBX8eb61WWUqlA+rCQvpv0
	q/e5JG4q2ItdIVhvFoly+dXjWD/+DRyLWA7RRo1CZvW7828u3yK+RBk7U/h52F3HA6WE3fwae629l
	z499h0fg==;
Received: from [172.31.31.148] (helo=u09cd745991455d.lumleys.internal)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvv2i-0000000Cs0H-2VRb;
	Fri, 27 Feb 2026 10:25:57 +0000
Message-ID: <be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
From: David Woodhouse <dwmw2@infradead.org>
To: Wen Gu <guwen@linux.alibaba.com>, tglx@kernel.org, tglx@linutronix.de, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mani@kernel.org, 
	imran.shaik@oss.qualcomm.com
Cc: vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com, 
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, 
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 linux-fpga@vger.kernel.org, imx@lists.linux.dev,
 linux-s390@vger.kernel.org,  dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com,  taniya.das@oss.qualcomm.com
Date: Fri, 27 Feb 2026 10:25:56 +0000
In-Reply-To: <20260227081934.96865-1-guwen@linux.alibaba.com>
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-jelaBrtampaCjwXLPKWD"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-jelaBrtampaCjwXLPKWD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 16:19 +0800, Wen Gu wrote:
>=20
> Patch 1 performs the refactor: move drivers and split Kconfig/Makefiles
> accordingly, without intended functional changes.
>=20
> Patch 2 updates MAINTAINERS to match the new layout and adds a dedicated =
entry
> for drivers/ptp/emulated/, moving review and ownership routing for this c=
lass
> of drivers away from the netdev maintainership.
>=20
> No userspace ABI changes are intended, this is a refactor and maintenance
> metadata update only.

While no ABI changes are intended in *this* patch series, we do need
some.

These 'emulated' clocks mostly exist not to emulate IEEE1588 per se,
but as a way to provide a precision real time clock to systems
(especially virtual guests).

We have already discussed the need to expose clock error bounds, and to
expose paired timestamps against the actual hardware counter (TSC, arch
counter, timebase, etc.).

Another key difference is that we'll generally want to be able to
derive UTC from these clocks, and feed them directly into the kernel's
CLOCK_REALTIME.

I don't have strong views on whether we extend the /dev/ptpX userspace
ABI, or start to treat these 'emulated' clocks as a class of device in
their own right and just shim them to /dev/ptpX for compatibility.

> # Request for comments
>=20
> 1. Following the clocksource/timekeeping and POSIX timer areas, this RFC =
routes
> changes for drivers/ptp/emulated/ to linux-kernel@vger.kernel.org=C2=A0(r=
ather than
> netdev). However, the preferred integration path is still unclear (e.g. w=
hich
> tree should take such changes, and who should collect/pull them for mergi=
ng). We
> would really appreciate guidance from the time/clock maintainers, especia=
lly any
> input from Thomas Gleixner, on the preferred tree/workflow for these chan=
ges.
>=20
> 2. This RFC currently lists us as the maintainers for drivers/ptp/emulate=
d/ as a
> fallback contact point. Ideally, we would prefer this area to be maintain=
ed by
> clock/time experts in the long run. Suggestions on more suitable maintain=
ers are
> very welcome.

I'm happy to be involved too.

--=-jelaBrtampaCjwXLPKWD
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNzEwMjU1
NlowLwYJKoZIhvcNAQkEMSIEIApMRR6lrWlfy1F7DLIOd1tOhNa/sPYF5xTZs1ErRG4PMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAux2gS3uE73/T
/y2EdDngzAENt7K2hUVP6wb56ewP4zodfWLusjZMPhpVfg96MY6svcvPHcHpvLN+aXHRI0qOWklW
SQd0jUTzta0wekkJ1THbUxB1skin4l3YBHiutb6A5Y4poK5lD3s7JpWTcgzubteDbTcUOIMjkx7v
ZTAB0eAXPzhx0SbffIh7PiEbFn+NpJf4nONvf26PwYBzg0C7UA3BxZBzeH0rud7nSKcbQXUFXxkK
LBsByUhsKr0P0LRDWlVIp29i/jcKBrsF0sJ8IcRP/z+eTe+tiy4WIE/Klr6xLe+vtR6EgeN8pgV7
ITyQ3ZBHDKhbgfdP6QaN/2xXZ1adbVqacuB1kSnNU2nZo/5joXYuGM2msQ1FNriNQNpiDNplk5+j
iBWGoAlwjGpSqBEFRRLJThnxc4KL0Z+2n1pQiPQZ5AMEujW6QWE9tikRCm+GAHLxNV6ghBGglWyg
/Jtg1RzrUT1IXdFwGhpC+Ejyt7tmxgYAeOPZMePSnoB/bwVazRtH+Vy+kFaMBJTnRC7cdM3rVCMy
8f91DumnNMJ1QdNcCBI1S58Ym+bSdwQILvGT82ErGwvVl1MviD8TUJrXeASYxguD6uJiHqPHoVGC
ZacMcn0ZmEliBL2Avhw7etrZcnyNxkUHLg9JLamdhcukzGoZuoEl0Xkj7nHNcEgAAAAAAAA=


--=-jelaBrtampaCjwXLPKWD--
