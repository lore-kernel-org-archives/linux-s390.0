Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86134E770
	for <linux-s390@vger.kernel.org>; Fri, 30 Jan 2026 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759046; cv=pass; b=NY7kzOIQByNmCXMOUYs5ARfyc4nlRl/3z0EsFQM4KZ1+z3FlwdOui++GAoLpqvFcmwmKhkISHz7/xakTHu0MT/CUtDfccA6BiSXRiRVrn0L8OhLgqe2zYhM9DKISJAnf8eXU5wUj/1ubooyl3LxlgpJeYRK9QB51aYFfUAV/haw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759046; c=relaxed/simple;
	bh=UJs9e0YbIzR/Z6xnmN0/xeDRW+TCiyFm90XII90WdSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpvkny/8XUEtU45VEUcixJrXjPuJsfuB4WVJVk0+E6cQD2OC/I7or6O4YOXaqm7KwuS2kjWB43IYmAIipUdbGJRcOw8DCdoHtiuLFtJTgKgpDoOH/hlkLWwfotPueMYS2J6yptLlKBds0wi+jU2RfLmvwI3D20BS/MmSoKAZXdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrLVKVMZ; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrLVKVMZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-435a517be33so1165188f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 29 Jan 2026 23:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769759042; cv=none;
        d=google.com; s=arc-20240605;
        b=aT+ILKqaEcPEaB63yBDMpX3CQ8IR4/V0sq+iTdErV+5a4NtVRpefcrwtcPWBMoHHPv
         4geIx7UVx55wuk/tomQJAgYqPcLxRO7YVzqAne3p0bU3LRX2sc9qvJObqQciEcmoWXU9
         Q7GrGjfGXGhd4okrqWMLw2BJkwQeJO+ZY8auoH8ecU3ei91D3AnBfFYU+Ts0J2Ueh7ua
         iqLvXRKUSkxHBNWR1sW64mlqwG8uI0gu+GnCNhsuAiYVo/d1LsmeJGTg8rqQ0QH2pPm3
         M7uhJ/v5v3UwQaQEoIGB8HwKN3uhFy5ZR1GKpH63rLHyykXFTga65wKums3VZwZp/30y
         pbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJs9e0YbIzR/Z6xnmN0/xeDRW+TCiyFm90XII90WdSc=;
        fh=ogyZYxLnFrO1Ku7QcVlIpHuyyypNskhB7KWI9iYxcDg=;
        b=f96orPBTOCxFRmyqo8eqoNFSLSbTkaWgUC0w62wNBh1v73OzOZdU4hfkAJxzTn/wHz
         eIlGbgRA4W8enQXC8/C8b2HC1YWFj8TZ8x4w9rgX70zU/mB9Cs0BTBhFGiGuyRBHLEiT
         G3LDLfsm3DcuPd7nyOX+9h4HnF8HQV//kFtfnseaxkK4K8t6c8Bz8fN1mAgVsyV4s63+
         yfqWtEPiQkyzuXV2XUDlhjv2JQK8i1rhgzbEYIFyjrvkMdHDFyBuZ1jchVMr6MAxq7Qk
         FWVX3lswAo8MOxlRg4pqvbqJ/dCHgymT+Qal09+k9Df9M3c2LEtJMdmfJK2ywXFq2rmT
         +EJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769759042; x=1770363842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJs9e0YbIzR/Z6xnmN0/xeDRW+TCiyFm90XII90WdSc=;
        b=PrLVKVMZzEa6Lw6LppGqr/k3D8i4cvmu5AXhc+4p0aIfpSLw5nRs+/BnbPRSNypUat
         PKVrIWB3C6lODoEIANLL/27uVqgU1ICxNI5T30tadb388cb/lxl2GpaNj1R5GVSmEjrJ
         5YkAZ94Ri683lH3ExVObnYZxNJVWAU1hrzL4iQbeNL03V9TOWHEf2L7dK8cpKE3V3+3x
         SynvGcAAplYhUqQQ0olx2QBkVZFYJsgon8iJh3E76OkZgfE/iI60htpGGC1QpnlvmLP2
         RvOQkePMApmmUTu7CwFq03c5f0LjNUYrxMHTD4jynUpGogY/I1qV2+TVC40zReKNEKB8
         gPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769759042; x=1770363842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJs9e0YbIzR/Z6xnmN0/xeDRW+TCiyFm90XII90WdSc=;
        b=UbUbiSE85m4DHAy2stB2d9bf7Au9xZj+5XtvWjV4jQfIJ/+ylpw2H84KlkEPQwrQni
         cQNQAXVWxxzq89rf0qwO+emTS15+A/z+DOYjXh7lB+nBfUFFrfMoTxUwoNg3+pNGm2ql
         cHC0iNGGEBqoXVKBxIelJ4tLeSGqbipLDFhZg5p2OGUzlH3udZVc9woOsO/LyjBBIrQV
         QlJZT6oE7YVtalrTqawePoBfKPvbv+mI894CQfmKdZN+jcB4pS47ORLqnvXY0vXEkdBp
         cVUPnXc8WdcRaq7feI/EpoO9T4Fo5I/ikJoxeEr1whokMF9daAd9ieKIZrNulbY+/v5M
         4eMg==
X-Forwarded-Encrypted: i=1; AJvYcCWxQStXcehofF8zyX9dXP9s/PuOqbzcziEoLAmr0LEU1fhi/nkLAAH4fJWJsRhP0pBcoSeBgvrFXu0/@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVK38mnv7wseRYUJObQcVK1keSlVW1qjtUSK9ywG2xVRanwk9
	zd2PoN9INR06giuKErqW14UlZ3uS1eIdsRIbG7roDky/cyIAANluBPl4ZP7uahiWW5xmGPEkyCD
	GIGZSYNKjqjgPY+Um8Av7o0UJK0Vf9Q5JPgYIYUrz
X-Gm-Gg: AZuq6aKKNyc5J7+v9z1cADUQIk7Re0JZH13HC0AkoM2jVOQ/fOBhhqN2Jpb/tFpxnbh
	K8gXDnTQQKhuSBieyouK0x4LI4GtjO4Phz2qA09vKDStnSzTNPa+fX1qXUZC+U85ko1iTDtMRDA
	+/1ioE5OptvRhie+uKfIt3DUEHkWj5Edv79VmP9ec0nTffx/NzqMRvSWQ8L0sXOlihhhstmJfKL
	hFQBn1j1nzS2lvc75kWugrzmMmpKcCNKORt4aBjrrW7NAGV5p4cJzyBduVkKGvTWFgibg==
X-Received: by 2002:a5d:5f82:0:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-435f3ab2f8bmr3170440f8f.53.1769759041535; Thu, 29 Jan 2026
 23:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124054134.71369-1-note351@hotmail.com>
In-Reply-To: <20260124054134.71369-1-note351@hotmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 30 Jan 2026 15:43:49 +0800
X-Gm-Features: AZwV_Qh9fGVkNfUiRvz-ASmJQ6vwlGAhram4n7UK29bp3f6E7zK0HOR_D-CwIOY
Message-ID: <CABVgOS=w3N2gKmJDZ5LTa3Eyqw1=+Yaedy-_mwDbBZWUR68a1Q@mail.gmail.com>
Subject: Re: [PATCH] lib/random32: convert selftest to KUnit
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org, visitorckw@gmail.com, 
	brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000c8f090649962306"

--0000000000000c8f090649962306
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Jan 2026 at 13:41, Kir Chou <note351@hotmail.com> wrote:
>
> This patch converts the existing prandom selftest (lib/random32.c) to use
> the KUnit framework (lib/tests/random32_kunit.c). Unlike typical KUnit
> tests, this file is directly #included into lib/random32.c.
>
> Only the file name "random32_kunit.c" keeps random32, "prandom" is used
> for all other places for aligning with the API semantics and avoiding
> confusion with the cryptographically secure random.c,
>
> The new test:
> - Removes the legacy CONFIG_RANDOM32_SELFTEST.
> - Adds CONFIG_PRANDOM_KUNIT_TEST (defaulting to KUNIT_ALL_TESTS).
> - Moves the test logic to lib/tests/random32_kunit.c.
> - Updates arch/s390/configs/debug_defconfig to use the new KUnit symbol.
>
> This commit is verified by `./tools/testing/kunit/kunit.py run`
> with the .kunit/.kunitconfig:
>
> ```
> CONFIG_KUNIT=y
> CONFIG_PRANDOM_KUNIT_TEST=y
> ```
>
> Signed-off-by: Kir Chou <note351@hotmail.com>
> ---

Looks good to me. Thanks very much!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--0000000000000c8f090649962306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgpSYem9nWBrQlpv5X0CSAF1Yga0+z
atPvIeH3mVZ+2BMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTMwMDc0NDAyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAn7r9VAUioa4XMdc0fJHLrRSYnq1Vnw3FkARqkTt/6x1DwDAvA1cTOkJ1ZDeIUPle
k4iOfhMPKrvq8F+3VYcwkOrbRwDRL9fXWv7SxgWWOk4tRK3i33S2C9bNTYbqg7S7hxKiruJuNiYG
IAlH1JZmdd1/aKs+20SvsFizjhi8mB/fjahpLnYqsQodikLlip1VbxSy4OCWLuWPRPDkFAjapnCB
hf5Z+tuaOjiZ4ZbRL9cMVi2P+qVkQPvYC6PeGtHLEej4RdTyRaqsWm9cktreuN497E4oFRT61nIe
/u07JdkHkEzPJVAtvsUDKAU95kOKl/RN1W8+GlphUdViuFe5/Q==
--0000000000000c8f090649962306--
