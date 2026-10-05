Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88C364052;
	Mon,  5 Oct 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230106; cv=none; b=MG1XL1yYuj28RY/YjyELiiwP/fWom83Rsv0N/EMv2xrZZRLGpg8oybzUHoBEay/kozP74PYSwHLu21V0RBbHqD46wKsoFPnKwDWNkR4hzbIuFOSuZRK//WPgTEpn1qCCZOfdsLo3AxBryo7t1rA0x0p0XSUCImjw35KL7mwlLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230106; c=relaxed/simple;
	bh=x4RJ9slhE19bh0sctfOAgtJX3+6KVlkfvvzHMfGESX4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=f1j9Wf886P4TEYWsGoy+VsnhsYw28h3pH3CZ2keuYikjEQOb6fmQ92awX1lc01aLPcdY/9x7BhgcNyo6TJVsUr8o/FZ3HBZ8lrdmiDMvgu1VDfI5jMgPrtVOk9ICbDdtNQMmlwbSgkIP1n77MF8Y8pjw91FtBXbf2Vqfbade+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHtxUSBQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHtxUSBQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZOI51256926;
	Mon, 5 Oct 2026 19:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LtvyO7
	ikMwu5WQTiyBbH02VDBqab3Q/tfzWW/s+e4IU=; b=aHtxUSBQ8mXrLTXZuLmNKE
	rUly5D9UFNTFBUqP4tV+Yj34XSTZ/7LKvMHMWh3SIQerwD1SuilkhiU2KI5IEoDs
	6EwN1SNzO+gaMBtaMP4urohzH2p9uy3/gxrMOBTaQBIqC8C4Vjti3WFp7+u7stkP
	zzJZVVzfOvdgXl4oSVBHcPSZqpgaG+vCIkDm2v1Mzcu4InbeDSA+rS9v5BUwq6gV
	WMxw+wJj7kuBPikCpPaAmAogLnK5pUQdCAVyhsV6oOiFjuvYcGZzXzq1OrRZE+Ln
	7VdL2aHhTnpgY+hSRRnMFv9wXH5JguDmvqCW1Aoolw0bb0l131oa946IDuXHgtaw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5c6gd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 19:55:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695HMbXU3280962;
	Mon, 5 Oct 2026 19:54:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgpuyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 19:54:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695JswDk39256478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 19:54:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9341658043;
	Mon,  5 Oct 2026 19:54:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F3C75805D;
	Mon,  5 Oct 2026 19:54:55 +0000 (GMT)
Received: from [9.111.90.46] (unknown [9.111.90.46])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 19:54:55 +0000 (GMT)
Message-ID: <023ed9db17d9c7d785dad387fc18dff6bed862d8.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] s390/pci: Reuse FMB buffer and preserve state
 in device re-enablement
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
In-Reply-To: <20261005154557.57801-3-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
	 <20261005154557.57801-3-oelghoul@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k
 /ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc
 3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/
 2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVS
 XQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9a
 UlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1d
 w75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakY
 tK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19
 /N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZ
 dVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQ
 JXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/Fej
 CYJAFAmmAWs8FCQl6sYAACgkQr+Q/FejCYJAn2g//UKzlXOgizdk0wudLooRbGzDo23ktGSPK5Oj9
 9o5z6v4Jz5+qOHo5835683cqkMLM9//udA1ZcKV88LVwyfmoHChPW24cWBmOEy7RJOWCR4WeEINaO
 pZUGF5YOx7oKTkPs511ky2FR0Heg35754pgTuTMEpYzRXr5pNMPS8mHXcXSARFPDPaCF+uBJ9BafO
 L7XbpSwKRttePsWAlPHbSbloeDApBfHUhcF/pbuM9GNs+c/8V9NK+SwwqNK214t7jaSq9k+19/hfE
 jvU45nbiYQM4VqGCelxVFRWol93JnwPFp/JaMgxgV1VYFH9Ijtgh+qNVVBqO8bbTjioFKy1bHdprN
 9GyPLDxoaI/lBg+5CwKewzazUjFd0xaqZbTXSgNK4ev/IuNI3qZV8tpvZZWwIgZU1K0Bhplt8Sku+
 O9Yl2H54erq9zuzwXjqBJtoW0+MaKbe+1gZ/v2/AVE2VeQMugPUWDg+2bpJaApRkeA4xQ9XfeW6Bp
 It7xYrwwbVhQtWRC0sRh+QNlU9HI28wPSnLWn7HFBeWupaIrxSp4IEL3eHUn8xv4aA8lpdNsHXD/X
 vqOSUwy5jlTPTlemvwaC9mNHagNdVXng8C6+hxiDLhZ6xH2P4qNHTKmjW61NsdF6Y/HfWP+lmbi8/
 474UNCltDt/fP01ajqogfWZKFymoH0O0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQ
 GlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y
 3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAtIw//WmQW/Z+SLdfrlDH5J2bvixzFNnO
 TOvp8uM8vcNZsxZwPXem4AeCXHayCqipxpa0iXWufEIvdMxkBxWvvM//V+rTUgQnJe6nhDxfLGklx
 5Mb2H+K/ndS73ElCuA30MPYq7mHr8i3gEmi2ZFX1W47JecJ8hno/DQxhHRG7bd+GFsiKCbsjLWXNq
 s/VaAK9uyOTQx7m6/2nR8L+Mvl1BrRXwkj7Qp0qxfQSd4r+IVNBzNFOcrGagBqsyHrN7Is7IICktH
 9VFl/G8P+hfviHQLnlxw9ltzpM1Dy6N1+BM3kbqD59gX+L6wqiLJI42eh+SHCiy35FvD3AFlYx4jZ
 MWE6qIgFnbwcL1kvcA7nnwfr3ZizCYPm8e334xXxslXBoRGsvjXSbAeAyZo2dvJXffNHdcDdUbJSl
 CfOixNGGKiQvs00X9ekfq9WmmRFvmYHu/m3lg1OXnMjFFIO41O51ZdhbEYJiqZEki7jA8Hd9xuWwQ
 nFDHhacU3xxivZ4BKQGQc+4XZ3yp/q6+7ux9prepRy/LeRyoaAmE67oxEsAgj+qyA3Tfy5nRTDdRQ
 E//gpaIt9H1VEx+68dRWHroxBQeozpnFPi25AlX3k4/EtVZjcItPWgE9iru1qT4DH3BBrz7Kd1zUw
 NnQC77zDJyZD2WUj1E+5bftO0aeE+7HZXj3tM/ea0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNj
 aG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSds
 ACy0nUgMKX3Ldyv5D8V6MJgkAUCaYBa6wUJCXqxgAAKCRCv5D8V6MJgkF/TEACOY2kL4NGFIbWeM5
 TUhatxqe8c3RT6jvNjq32CkvaK/cSZzBkS0smddyOzxt2WnsvMgkr9cM7P+CevoMwhT3e0lgQbqBD
 /vXZJjWKddC+iKXeqWkjMVcgCOsWNZ7PWEzRUT5X1AEFq2zzxQAQ/bCWEYNqIbHN4b6G1Wk+2Y598
 +KypZ3FS0bwiItnPQOWzOOqJCGxDxaEUuXFx4ah8HtVdtIev8jPS/5uzQO9iG2vZQUWeMEYZtfMHW
 sbFWqo2A3lxB+KPzNIYFhul4Lyx1CwvKUAGSHOx7FZuc2xI5DYt/Wdh2QyKFYr7xVzv3uwJjeS1+3
 6gvyB7DJaQuY+PziNPv4GPr5wy0cRkJ6Ps15fgC6y6wNwoNdNXKlwiuclIsBzJKa7A0pZMIfpCpIJ
 bEHP7oy3drBRAhIrBx7Lx1lyqqodDqc+ok5IQ5WcKG/TOrH732mTmJX6fxYTiCVxcU4WLJSNZbrZ/
 pjF0AWXs7E+onAkQy6RLg/XU1iiU5QdMvug+fTA6TpPSUMdujWtGWUt3/4nC+69AVc8tXtRQTZ7gP
 t7uIcQFwPqUuJGS26vl0w/6dIABQAyU9acvE3adCZra+/PBKFZi/yxT1WgV1T2mexKSWwQgLcR57J
 Yp5oWnQRgi/S6fAoskIWkp9UVcfAQPY0p45NwO5cZR9/g06JZmyrQhTmlrbGFzIFNjaG5lbGxlIDx
 uaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAA
 stJ1IDCl9y3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAz4A/9F+dMhzu7YonagL4qh
 WDz5IpRD4vzYKOBZ+qwYp1ugJz1BIUppN9i68HKoS4ARfgP97Sv9GpOy9g7L0lymH2MPF8hRPK0Yn
 7DKIkeu/r28YWEoWfoVm5reC+gpxMgmxBz4JScE4f6xfa7+Nw0bbTDl+nxftJD7lf/dTiruNJsXph
 HQnZ5wPXmxeH6XVJikfpyrGe8iJZALbtHtjlx6Omu7NvRGikenB8trrWS5W0F60ZdbqH1HdmDDcrZ
 pDq6LtAARHK5tGRm0SK6sZpKe3nULFeeCt7T/edk2FC6KVh4sL1jw1kyceX4DjiMffqYBPrhK5gz5
 cDIixLBF9C6Wt1ObvuDBrIQf1/3q6EZrUrUuf6qtaXDMuC6cSlShm47qaPEvVYh67O9JZQ7vzvaea
 UI74DJUb8Pjnz7mTOmMOzsS1gUhCue4n2YSSM6ythioCGb/3bgMGTpuer3JhvZG5s5uKD9yyj8s8x
 35qJkCFfjmjVx9s3vSUS48X+cUpYcMispErKzFu7C0YgKoxvJ4XTfXlDBiMFMPYcN67hsb2jeYHVJ
 wzE+fIZiDx9JLh1oQW2krwjweisE+3glOaKXZKi0fBtkxyH41iemLtLNYZRJopv6ykdl3hiI+Nh+a
 3FZJPTo/OpqchMm8XIeDxC4NFFiPMpyLeYzIxO7eZpiGrAjVTE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 21:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX7eEmepvKfkdG
 GEOqPEuw3UMUdwnHPfclJsV9RvrgNsZKDhRnpnnChb+XVIgsrtDXLsQ5fqmGY7bh9CYljsMrPwT
 qfj+EGZEuHW0WIYOnokiMd7bpvSC7kE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX0dqZ1+mZ7mHY
 /z7VLMMVjRx3zGb6lhnFuV2DOVt7EUNjGNM+jfo/1GT44zdtPecF2gtNzlUQACQwm+wffBpWxrW
 qnsRDMi9qt8AUR6whrE5l0Yvmfk0JpR1Vg5dP1wP52xwTt6IKACCcSiuXcs58wmp5caXMpiWLm/
 PrhIR/n1ElmpRPh2EqXu+Sn+IQgaCWOrCNrDTSrzePf5EDLlSpVCwKLo7ip1GtDIW7Xz3MIKVxM
 d2KbI6qe5OM08YUOS6bsaoWaA/nmnISnSLvhq3DE806gpMmDKm4AxpANRn2Szxy6/BMiUWd9hd3
 H6hwJJDeRV2xWgN9MyPBgxhgbIREU01RMsejZ+F9T6CG+sEAsNC3bs8povxKr7DWrwPswjv3UgE
 I/B+7KG2i1f0i2D2rKjrlhEgehJIqHsccNFg/cR96UXDm3JcBEniNWCsArpUo/gbsK9VPVF7vKt
 BWPkI/2xU7GfWg0DViA==
X-Proofpoint-GUID: CkgVKNwN_qePseuf8iUZc9VsJd9Xo_uy
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac40094 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=AKlWO90MWbHe4YM1njwA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: CkgVKNwN_qePseuf8iUZc9VsJd9Xo_uy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050077

On Mon, 2026-10-05 at 11:45 -0400, Omar Elghoul wrote:
> Don't free the FMB buffer when disabling measurement in
> zpci_fmb_disable_device(). Instead, make the buffer persistent for the
> lifetime of the device and reuse it across enable/disable cycles. Defer
> freeing the buffer until teardown in zpci_release_device().
>=20
> To support the persistent buffers, add the fmb_enabled bool to struct
> zpci_dev to decouple whether FMB is enabled from whether the buffer has
> been allocated. Audit the only consumer of zdev->fmb as a liveness check
> and update it to reflect this change.
>=20
> Introduce the function zpci_fmb_reenable_device() to ensure that the FMB
> is enabled. If it was already enabled, disable it, zero the counters,
> and re-enable it. This allows the function to be used in both first-time
> enabling and re-enabling measurement. Call it in zpci_reenable_device()
> to preserve the FMB enablement if it had been implicitly disabled by
> firmware in zpci_disable_device().

I think this causes a sequencing error in zpci_hot_reset_device().
First the device gets disabled via zpci_disable_device(). This
implicitly disables the FMB but keeps zdev->fmb_enabled set. Then we
call zpci_fmb_reenable_device() in zpci_reenable_device(). Since zdev-
>fmb_enabled is set we don't first enable the FMB and instead go
directly to disabling it but that is wrong since the FMB is already
disabled as a side effect of the CLP Set PCI Function (Disable) in
zpci_disable_device().

Also, and I think Gerd mentioned this before, there is a disconnect in
semantics between zpci_fmb_reenable_device() and zpci_reenable_device()
that is quite confusing. While zpci_reenable_device() re-enables the
device with existing interrupts and I/O address translations, after it
was disabled, zpci_fmb_reenable_device() on the other hand does a
disable and then enable cycle.

I think the idea here is that zdev->fmb_enabled tries to track whether
the FMB is supposed to be enabled rather than if it is enabled.  This
makes some sense since the FMB can get disabled by the device entering
the error state or a zpci_disable_device() and we want to know if we
need to re-enable it at the re-enable of the device.

Importantly, unlike the disablement of a device we always initiate the
enablement. But then we can't try to disable the FMB without knowing if
it was already disabled. I think a possible solution for this would be
to have zpci_fmb_reenable_device() mean that we know that the FMB is
disabled but should be enabled, which we know when we re-enable the
device and zdev->fmb_enabled is set. Of course then it doesn't do a
disable but only an enable despite zdev->fmb_enabled already being set,
Then zpci_fmb_enable_device() on the other hand sets the flag initially
and then uses zpci_fmb_reenable_device() or a shared helper. Of course
we would then have to properly document zdev->fmb_enabled as being a
the target rather than current state.

Thanks,
Niklas
