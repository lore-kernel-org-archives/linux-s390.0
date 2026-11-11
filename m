Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429302;
	b=g27tnJ51OHHADce1KoxrMYmtwDa8E5B0Ets5fUjcOVqEW8XpXlgNW5dh8ZToFPAEkiWs
	 wPWSFEscLV4j578oCIo1VIsqNA7i4F7y1/1Ji0Y3nUBSkuFctESh5CMxm4R6lRCrmHRyE
	 T29Yi8MXYDX1hGZYgAqkhYK2QPpYxDzqZY+cwdyYO0BoWQzEBFqNOFdCEHOo8O/8Bl43i
	 Ljh6ZexsMPkdd0B4dlIg5c6dPVzETp/1O5v6S/sjAkVO8dkX99R22QlsvxRjq5azaKR5K
	 RT4NYjKhlALRirbfeDGjFONvRWr43ATFRXm5LZFZSoS76FysJPmBplmCGlu6TS1xexQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PIb0SNrbZDhIxD2ECVOlftElqLW3vPwEV3I/mhGvzh4=;
	b=oJhlAxHew3lyT79GML+M8PUfBQ9PQ/DmA0NMO51XZjvpI6P2DHDqF3bHbAdmFLemg7Nq
	 x79Cba9WFRPoZJ483rXH1YtI9AaTw29RE+Pc9dLdqctcjgzDRbJEdlA3O+OjAViFJ3SUq
	 ai04ipGs2fB02X4NPdPprYZUVLfd78+3Z1qqNDvrYMbIiSPldNDG137kwgyAruyYTBzM9
	 FmgJp22jIqLtWKt0tLYCysY2mENrXsbe418SkbKK1QOrpFvYUPDrlJ+Yrkv+7yLsDsu1t
	 vF4x7zzcZMP4p3vKGjRh+Z0JFCCbrfCBpjYZx42fh1qJ+CJwObAWgCUdyQpdyEyiGGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SvTMOmEg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FE606A327;
	Wed, 11 Nov 2026 20:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D17FE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SvTMOmEg
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiB4o671656;
	Wed, 11 Nov 2026 20:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PIb0SN
	rbZDhIxD2ECVOlftElqLW3vPwEV3I/mhGvzh4=; b=SvTMOmEgE4/N3FcY9evoha
	6NxNSbuW60bJeWVdCLAdmB2ICrLwxrzd7jfXWgodR3ac1/wv+8cZnl/rfA4Qj8Qq
	DSjcwZMp+SgTxpqiODoJtJDLnBoftmplGntF6/CacPW3Lcp3NdFRiWRp8byzcdyc
	avPRAc2w3XoxJN3bmM4EmrpoCkGUFweF24lNoaDk84JioqNUG093iajeFLxiawmT
	jidYZNm5bM6the7zIg0wm/tBKlLfThl0DTdUEwJlORBseSmnJf02CcWIEKTeAJP+
	QjeHbdB+xs9TWfxVG3WFRtATR1iYJTnEhsnMVgsCfc6RvUnscBTQvvTS7lH1LnoA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgbhx3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 20:35:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ5Zn3822823;
	Wed, 11 Nov 2026 20:35:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthvech-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 20:35:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABKYwXK27722364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 20:34:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F96458058;
	Wed, 11 Nov 2026 20:34:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FAD58057;
	Wed, 11 Nov 2026 20:34:57 +0000 (GMT)
Received: from [9.111.22.170] (unknown [9.111.22.170])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 20:34:56 +0000 (GMT)
Message-ID: <69f5f7364b4fc158e9793c08616f59b8efe6ad40.camel@linux.ibm.com>
Subject: Re: [PATCH v13 2/5] s390/pci: Improve function measurement state
 management
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Omar Elghoul <oelghoul@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>
In-Reply-To: <sashiko-outbox-209403@kernel.org>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
	 <20261111162758.9792-3-oelghoul@linux.ibm.com>
	 <sashiko-outbox-209403@kernel.org>
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
Date: Wed, 11 Nov 2026 21:33:56 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af4d174 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iB0FYdh9rNnPMk3quK0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4MCBTYWx0ZWRfX9PGNMZBVEs+2
 pp4CP7lFahcd1taGhDw489G6EavkVDD0TJFGJcy1siigYiIxvo9LPWoy86ajKmwVfsm52I+nR+/
 NwUtR6NIN6YnQhhnsAWXs7ILnOPz/MTDIqUAcKVZwyrihuyD4rRvyA3xIhKgb/gnp6AoVKk8ZWX
 HcEC1G9/22vp75Iuaha8aV+hvk67T0SJrvBE4/LPo4Z6AfmR0e5/UIo1cZziynAA6VYDGE5DPrz
 evqMZjTruggNDrcklGwdmJ2cZ8gtBg7aRRDuv6hVSQqm1Rt2TrwWbqqHMNETWQmCajMZL18Aoii
 RG1uIp1rYTPWbiqfZ1QbFTYZnI37Hv2h7DOZp3nRqsP9DNw/f+ZSPmCZdxMKeDGeXMlkBTbwSCA
 9xqJuv9Jr6oUzFWvubiizEZXloR53e7+t4fzGlSkxnB9qsP/Sx4kt9gjvg7d9Yk2ookuDfocML9
 iWU5l5q5LoQu50uvChg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4MCBTYWx0ZWRfXy7Ft9QC84mMe
 3wWNnRMlgzaeGPsNyAz11wUONPSfB/SjUx1kptU6P+zxeJ26SrnoNkzFdX6tZ89emrlni0qqEqc
 LCpPAYWT/u64y9wGSOo/uVrBW+IfSd8=
X-Proofpoint-GUID: 0Rcj9FjIqstg9lX9D3PxtiTHYTfry5Xa
X-Proofpoint-ORIG-GUID: 0Rcj9FjIqstg9lX9D3PxtiTHYTfry5Xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110080

On Wed, 2026-11-11 at 17:20 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] s390/pci: zpci_reenable_device() enables FMB on disabled PCI
>   devices
> --
>=20
> commit fa84ea4339ffa82b899be0638304928f5c7daa03
> Author: Omar Elghoul <oelghoul@linux.ibm.com>
>=20
> s390/pci: Improve function measurement state management
>=20
> This commit tracks the desired function measurement state in
> zdev->statistics_on and restores it when enabling, disabling, or
> re-enabling a zPCI device.
>=20
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index c055a9ad09724..f49736386eb7c 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
>=20
> [ ... ]
>=20
> > @@ -737,8 +769,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
> >  	}
> > =20
> >  	rc =3D zpci_iommu_register_ioat(zdev, &status);
> > -	if (rc)
> > +	if (rc) {
> >  		zpci_disable_device(zdev);
> > +		return rc;
> > +	}
> > +
> > +	guard(mutex)(&zdev->fmb_lock);
> > +	if (zdev->statistics_on)
> > +		zpci_fmb_enable(zdev);
> > =20
> >  	return rc;
> >  }
>=20
> [Severity: Medium]
> Does this enable FMB measurement in firmware when the PCI device is
> disabled?
>=20
> zdev->statistics_on is initialized to 1 in zpci_create_device() and
> remains 1 after pcibios_disable_device() disables FMB.  Callers such as
> _do_recover() and vfio_pci_core_disable() -> ... -> zpci_hot_reset_device=
()
> disable or remove the struct pci_dev before calling
> zpci_reenable_device(zdev):
>=20
> arch/s390/pci/pci_sysfs.c:_do_recover() {
> 	pci_stop_and_remove_bus_device(pdev);
> 	if (zdev_enabled(zdev)) {
> 		ret =3D zpci_disable_device(zdev);
> 		...
> 	}
>=20
> 	ret =3D zpci_reenable_device(zdev);
> }
>=20
> Because zdev->statistics_on is still 1, zpci_reenable_device() allocates
> zdev->fmb and enables FMB DMA in firmware even though pcibios_disable_dev=
ice()
> already ran.  If no driver re-enables the PCI device, firmware FMB
> measurement stays active on a disabled device, and at this commit
> zpci_release_device() leaks zdev->fmb if the device is later deconfigured
> (though commit "s390/pci: Improve FMB memory management" later in the
> series frees zdev->fmb on release).  When a driver does later enable the
> device, pcibios_enable_device() -> zpci_fmb_enable() sees zdev->fmb
> already allocated and returns -EINVAL instead of zeroing zdev->fmb and
> resetting the software IOMMU counters.

The enablement that is relevant for firmware is the
zpci_enable_device() that occurred earlier in zpci_reenable_device() so
firmware is ready for us to enable the FMB measurements and the
sequencing is correct here.

Thanks,
Niklas
