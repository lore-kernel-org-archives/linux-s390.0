Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8F1649D9;
	Fri,  5 Apr 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316611; cv=none; b=gWe8WMafa91N2DI2118S9kbfAxLgdvXWLGmkFPjbOKojIG6cqQNqbevzL2aZI/NUtKvQuqFYpz0B7L6jNf0vEuUO7cz4MiOCosQjiZC9/VwMB2BHo8zn3GnmZNGy8rtgpoqEE60CY8kh0pnTq34UawzEjICeoghJezrKZleHhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316611; c=relaxed/simple;
	bh=2V4L8qe3+CTuFahMV+YklCVpxQKV3ulIRMRR/8O6RtA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEU46Y7Uhx2h3kMU7gosxRkN5sOFkKVwt5F8On+xMoRBTvt33uciKkc8iCVqV8seyXzh7/BU4QgyEEweeBO4qSolcXwl42OGL/cUmHqBV5jQt0W8ZZbDlxV5OojlbcbdpvAi8OXeGiggiEOvpeWsgD78B91RTNJu8bOjmgRTCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=beELki4S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="beELki4S"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435BRPxE004541;
	Fri, 5 Apr 2024 11:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=un+pIbB0k+n2I0pQqrXMsfw75ppUr36BA4TZrzejS2w=;
 b=beELki4S6+K2orITEwRmpo6gtKK7J4r7YqXvepa1zzRGy1EP1Xb9wbhml1poFInJ0mmH
 8Z7j4b/mgUfPTi4rl4PjfdqgYvmmZmZRa3QST1dV2EIJe/1/XXiXiWOWLqxp1384OWu8
 ylTx230flkqVcABSHXbzEB2yDcaZR8T94Qw5OmSCM6Lrb7Nm8B/QiNIo1jZfN3r+euP6
 aGDTJF7EX8XXh43hXJ7gCXYKw3HuAR4r5Ocqfw1I0dJFdvvDLfXJm+GqPD+JS9ZmdpF0
 KDak4TerY2mtthWmmQjA5E+EJcryfXFmChQy8wKBuBkdb+TcJSzKmQP9aTZkCGywiDR4 fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xagee809k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:30:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435BU4Vd009101;
	Fri, 5 Apr 2024 11:30:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xagee809b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:30:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4359wUnR022293;
	Fri, 5 Apr 2024 11:30:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9eq0j4d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:30:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435BTuqj46268672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 11:29:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F362004B;
	Fri,  5 Apr 2024 11:29:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D47C32004F;
	Fri,  5 Apr 2024 11:29:55 +0000 (GMT)
Received: from [9.171.37.225] (unknown [9.171.37.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 11:29:55 +0000 (GMT)
Message-ID: <1e31497c3d655c237c106c97e8eaf6a72bcb562f.camel@linux.ibm.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
        Paolo
	Abeni <pabeni@redhat.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>
Date: Fri, 05 Apr 2024 13:29:55 +0200
In-Reply-To: <50b6811dbb53b19385260f6b0dffa1534f8e341e.camel@linux.ibm.com>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
	 <20240328154144.272275-2-gbayer@linux.ibm.com>
	 <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com>
	 <cb7b036b4d3db02ab70d17ee83e6bc4f2df03171.camel@linux.ibm.com>
	 <20240405064919.GA3788@lst.de>
	 <50b6811dbb53b19385260f6b0dffa1534f8e341e.camel@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k/ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVSXQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9aUlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1dw75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakYtK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19/N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZdVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQJXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmWVooIFCQWP+TMACgkQr+Q/FejCYJCmLg/+OgZD6wTjooE77/ZHmW6Egb5nUH6DU+2nMHMHUupkE3dKuLcuzI4aEf/6wGG2xF/LigMRrbb1iKRVk/VG/swyLh/OBOTh8cJnhdmURnj3jhaef
	zslA1wTHcxeH4wMGJWVRAhOfDUpMMYV2J5XoroiA1+acSuppelmKAK5voVn9/fNtrVr6mgBXT5RUnmW60UUq5z6a1zTMOe8lofwHLVvyG9zMgv6Z9IQJc/oVnjR9PWYDUX4jqFL3yO6DDt5iIQCN8WKaodlNP61lFKAYujV8JY4Ln+IbMIV2h34cGpIJ7f76OYt2XR4RANbOd41+qvlYgpYSvIBDml/fT2vWEjmncm7zzpVyPtCZlijV3npsTVerGbh0Ts/xC6ERQrB+rkUqN/fx+dGnTT9I7FLUQFBhK2pIuD+U1K+A+EgwUiTyiGtyRMqz12RdWzerRmWFo5Mmi8N1jhZRTs0yAUn3MSCdRHP1Nu3SMk/0oE+pVeni3ysdJ69SlkCAZoaf1TMRdSlF71oT/fNgSnd90wkCHUK9pUJGRTUxgV9NjafZy7sx1Gz11s4QzJE6JBelClBUiF6QD4a+MzFh9TkUcpG0cPNsFfEGyxtGzuoeE86sL1tk3yO6ThJSLZyqFFLrZBIJvYK2UiD+6E7VWRW9y1OmPyyFBPBosOvmrkLlDtAtyfYInO0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQGlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmWVoosFCQWP+TMACgkQr+Q/FejCYJB7oxAAksHYU+myhSZD0YSuYZl3oLDUEFP3fm9m6N9zgtiOg/GGI0jHc+Tt8qiQaLEtVeP/waWKgQnje/emHJOEDZTb0AdeXZk+T5/ydrKRLmYC6rPge3ue1yQUCiA+T72O3WfjZILI2yOstNwd1f0epQ32YaAvM+QbKDloJSmKhGWZlvdVUDXWkS6/maUtUwZpddFY8InXBxsYCbJsqiKF3kPVD515/6keIZmZh1cTIFQ+Kc+UZaz0MxkhiCyWC4
	cH6HZGKRfiXLhPlmmAyW9FiZK9pwDocTLemfgMR6QXOiB0uisdoFnjhXNfp6OHSy7w7LTIHzCsJoHk+vsyvSp+fxkjCXgFzGRQaJkoX33QZwQj1mxeWl594QUfR4DIZ2KERRNI0OMYjJVEtB5jQjnD/04qcTrSCpJ5ZPtiQ6Umsb1c9tBRIJnL7gIslo/OXBe/4q5yBCtCZOoD6d683XaMPGhi/F6+fnGvzsi6a9qDBgVvtarI8ybayhXDuS6/StR8qZKCyzZ/1CUofxGVIdgkseDhts0dZ4AYwRVCUFQULeRtyoT4dKfEot7hPE/4wjm9qZf2mDPRvJOqss6jObTNuw1YzGlpe9OvDYtGeEfHgcZqEmHbiMirwfGLaTG2xKDx4g2jd2zOcf83TCERFKJEhvZxB3tRiUQTd3dZ1TIaisv/o+y0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSdsACy0nUgMKX3Ldyv5D8V6MJgkAUCZZWiiwUJBY/5MwAKCRCv5D8V6MJgkNVuEACo12niyoKhnXLQFtNaqxNZ+8p/MGA7g2XcVJ1bYMPoZ2Wh8zwX0sKX/dLlXVHIAeqelL5hIv6GoTykNqQGUN2Kqf0h/z7b85o3tHiqMAQV0dAB0y6qdIwdiB69SjpPNK5KKS1+AodLzosdIVKb+LiOyqUFKhLnablni1hiKlqYyDeD4k5hePeQdpFixf1YZclGZLFbKlF/A/0Q13USOHuAMYoA/iSgJQDMSUWkuC0mNxdhfVt/gVJnuKq+uKUghcHflhK+yodqezlxmmRxg6HrPVqRG4pZ6YNYO7YXuEWy9JiEH7MmFYcjNdgjn+kxx4IoYUO0MJ+DjLpVCV1QP1ZvMy8qQxScyEn7pMpQ0aW6zfJBsvoV3EHCR1emwKYO6rJOfvt
	u1rElGCTe3snsScV9Z1oXlvo8pVNH5a2SlnsuEBQe0RXNXNJ4RAls8VraGdNSHi4MxcsYEgAVHVaAdTLfJcXZNCIUcZejkOE+U2talW2n5sMvx+yURAEVsT/50whYcvomt0y81ImvCgUz4xN1axZ3PCjkgyhNiqLe+vzgexq7B2Kx2++hxIBDCKLUTn8JUAtQ1iGBZL9RuDrBy2rR7xbHcU2424iSbP0zmnpav5KUg4F1JVYG12vDCi5tq5lORCL28rjOQqE0aLHU1M1D2v51kjkmNuc2pgLDFzpvgLQhTmlrbGFzIFNjaG5lbGxlIDxuaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmWVoosFCQWP+TMACgkQr+Q/FejCYJAglRAAihbDxiGLOWhJed5cFkOwdTZz6MyYgazbr+2sFrfAhX3hxPFoG4ogY/BzsjkN0cevWpSigb2I8Y1sQD7BFWJ2OjpEpVQd0Dsk5VbJBXEWIVDBQ4VMoACLUKgfrb0xiwMRg9C2h6KlwrPBlfgctfvrWWLBq7+oqx73CgxqTcGpfFytD87R4ovR9W1doZbh7pjsH5Ae9xX5PnQFHruib3y35zC8+tvSgvYWv3Eg/8H4QWlrjLHHy2AfZDVl9F5t5RfGL8NRsiTdVg9VFYg/GDdck9WPEgdO3L/qoq3Iuk0SZccGl+Nj8vtWYPKNlu2UvgYEbB8clUoWhg+SjjYQka7/p6tc+CCPZ8JUpkgkAdt7yXt6370wP1gct2VztS6SEGcmAE1qxtGhi5Kuln4ZJ/UO2yxhPHgoW99OuZw3IRHe0+mNR67JbIpSuFWDFNjZ0nckQcU1taSEUi0euWs7i4MEkm0NsOsVhbs4D2vMiC6kO/FqWOPmWZeAjyJw/KRUG4PaJAr5zJUx57nhKWgeTniW712n4DwC
	Uh77D/PHY0nqBTG/B+QQCR/FYGpTFkO4DRVfapT8njDrsWyVpP9o64VNZP42S+DuRGWfUKCMAXsM/wPzRiDEVfnZMcUR9vwLSHeoV7MiIFC0xIrp5ES9R00t4UFgqtGc36DV71qjR+66Im24OARh5t9QEgorBgEEAZdVAQUBAQdAwhTH11wigg1BVNqmlPAcneh8CthXnZZf70RNLR9fWloDAQgHiQI2BBgBCAAgFiEEnbAAstJ1IDCl9y3cr+Q/FejCYJAFAmHm31ACGwwACgkQr+Q/FejCYJAztg//fshsI9L9eCmLKUdZIc0XuFJcek0B9ydLp9jPIGUjBDLmkqxZ6NT1GWx9Ab3xTVg2Zs6IuP70UhvRqRV8g2XQdkHia5NMnTqfJEZWncjBr9pjfbZJRjvm7T2IVYiVnAqPf/LEoVgztgG8RvtQ/lPRwnE+zPJ3bEBcnl+W5fguRxHo/Mom3XGlQCif3oF3uydWAKRef4b3h8nZmn2EBzj6J7juwek9x7SkxKe8+Vavr5HTwEHOBTMrsUH7DCp27zJ8MU1XRpBAjkn2YEujRx2z2cPeNloFX6z5F7T4f+Ao2xxcXUEXeEBz8XL94DstXGI1IULTC2ui99B4NL0JfiCAWOf3mrosppdjzgM0X6g4pO8gVR1C09+rr/fbp6L8FflQu01kV1TZkAgSAUe58HlbP10I9Ush6nE7Z9Q5DR/T56DXh1o8sW4dBMu6AWan7mFRPwVQqL9zN5m8n87uNb/jiedvhBeb22TihHvbheEWB3WtfaQjdykETR80bm5T+ACcrwBpPvXkOFKovWJVEvvsUXynfFQYoFj5chNtH60zhvg/eHI9ZCweQgwvCqAJxESTZSEMbtxkklSl9OfnoBzPFFia1JwqazmUl0N5WzaLPW1P9KjDSt5YxMu0jdh2MAPaHdxFO/G8d0VS13FjIy/2QAni8Zf2CRlj1q4q5MJ0vXq4MwRh5t9wFgkrBgEEA
	dpHDwEBB0CdY+CSLBT98n1BaxlG+VeVzL3fQUYZDqybI14E6IH+JokCrQQYAQgAIBYhBJ2wALLSdSAwpfct3K/kPxXowmCQBQJh5t9wAhsCAIEJEK/kPxXowmCQdiAEGRYIAB0WIQSiikNOrnCUNbxSj4j7H22hwInkVgUCYebfcAAKCRD7H22hwInkVtg4AP0cl7yQX1JjOa92zkytZc7rwsjmSzvYExyRV0ilozmUNwEAifrmLVNjn+fST7LqkjWpSdFN3waHM9rw1d88SE0z1QqgCQ//YJOcAVYrR5KruzYjfh/FHiimFfvoOcanPS22uRhteBEALvV7LeCPjU5zi8/TKd8KZ9FmvYCaUf4IWzKIe51szZgnWPXdxF7Eyz5gVdM7ZaS35Dk9CCH3gtVU7iUorN95+pJ5elwUn6DAMdgFWswCBWuOm9zwq6Dj4KHTE4b4iWDenTNECqT+qwiS1bAHNbljXtoM68Uo1s3WDZPYcjqPlsoSjkpa7kz1z0NygE0zT3vHq8r7aFs+kq2sPVveTGhKhqZ82l7rSZpxssutpEdhChKbshD/44VaRLyXGhtQaOpWpFPdELAsJIB9BG39GrgP9K8TXG/5dXDzmC2Ku0ftyLa4ronM1LXG515bxQUPKFxaBYQonpdDWQVBu9bzQDmT8itP44hJWGDurDaPrYh5GYuetzIj8zgDxnh/wfwCpIepUxdZCV2NGYQiMjxuXEf/u7a2164U45rSsOCeKAG97f1GeQME3RsHV+d8lDOdjU+AfiWXqIhP32DVa5xElE3xQAd7+mUoAjYhP9OdM9e8j/UO6e4TmBMLYIMJh+joXan5eePJDYdY/NuRTqPjlZnOlA6JzbWOstXk/3GwFVOAO6YxNJl0m+EzGSOAYmIA3HuohrwPcVGi4CSbZF829CAMQQl0cXGjfI65pZFM8xcaB+lMgykEHrZ2uf6Y+Kkgdo24MwRh5t+CFgkrBgEEAdpHDwEBB0
	AF23/zeAYKTtphGMg29j9mNBKDoRQS9I3Zih5SNpJ3YokCNgQYAQgAIBYhBJ2wALLSdSAwpfct3K/kPxXowmCQBQJh5t+CAhsgAAoJEK/kPxXowmCQV4UP/3KpWKD6EUIO8DGnohGUpZkD0qHSWVXMu6RuCukZeAMDaWdVkMW6SSFswUT1xGoGc10hxPFiR1Sv448S1DgIz1sRgZKDcvFFlPhJH8PAJArv2gaaBBhUj3IN8XH58BJ/q9we8n/lJLDCs++0QeQJEoOG0O5IiP8wGHLPSWa9jXiej5SBMbTx+wQmQZc6NQdv7O9gB3j86IRv3Ly2tHuOQ3WEAUQZvy1dzQj+5WHVOU9F99P6OfkzU8QW0izPyB3uVfxJkNB+K78+Klj1L1HONCfBVGz8vly3U4bXtWm0JuIBty7x9a0TPrSGpghs+rPRw8miHgkEB6pWiJzDek6jQLPMyEtUDs7/vgQEPBlDwVHxPvLtqzyjn0v+9T9DEFQo3i2zWfpE9AI7CTf3qJeqHFATtVzNQnA8j2X94R8R3r9oxzSW/z17zuDV2XjmZTUJlOuw8e99FOop2CFUn49OcfA7qm8o2vaatPy4aYahsaptmTuMZ6InwZp/LI1GX7egQyExtte7y/X0HAbME5Wa6UpYgxt689xWFlh+VAOadZ6c7UDDu8KZis+3z6PAXYOJK5naEHpYbLdyBZEvtXWVoYVCA69h1X6289XUAjbm1h7OS6qz9m7+8kjpoakIFUt75M2KKCJ9a6yaOGjiLj5r1vQzNgV16lOPsb1Ywf8p2/ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gub5CefKnyHIxJh1_icYXSvFa_MCnoOP
X-Proofpoint-GUID: Ahtqg-ur4oqVg2Sw_uQrdbZEK9ALEMvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050082

On Fri, 2024-04-05 at 12:42 +0200, Gerd Bayer wrote:
> On Fri, 2024-04-05 at 08:49 +0200, Christoph Hellwig wrote:
> > On Thu, Apr 04, 2024 at 01:10:20PM +0200, Gerd Bayer wrote:
> > > > Why can't you use get_free_pages() (or similar) here? (possibly
> > > > rounding up to the relevant page_aligned size).=20
> > >=20
> > > Thanks Paolo for your suggestion. However, I wanted to stay as
> > > close to the implementation pre [1] - that used to use __GFP_COMP,
> > > too. I'd rather avoid to change interfaces from "cpu_addr" to
> > > "struct page*" at this point. In the long run, I'd like to drop the
> > > requirement for
> >=20
> > The right interface actually is to simply use folio_alloc, which adds
> > __GFP_COMP and is a fully supported and understood interface. You can
> > just convert the folio to a kernel virtual address using
> > folio_address() right after allocating it.
>=20
> Thanks for pointing me to folios.
> After a good night's sleep, I figured that I was thinking too
> complicated when I dismissed Paolo's suggestion.
>=20
> > (get_free_pages also retunrs a kernel virtual address, just awkwardly
> > as an unsigned long. In doubt don't use this interface for new
> > code..)
> >=20
> > > compound pages entirely, since that *appears* to exist primarily
> > > for a
> > > simplified handling of the interface to splice_to_pipe() in
> > > net/smc/smc_rx.c. And of course there might be performance
> > > implications...
> >=20
> > While compounds pages might sound awkward, they are the new normal in
> > form of folios.=C2=A0 So just use folios.
>=20
> With the following fixup, my tests were just as successful.
> I'll send that out as a v2.
>=20
> Thank you, Christoph and Paolo!
>=20
>=20
>=20
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 25911b887e5e..affb05521e14 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -14,8 +14,8 @@
>  #include <linux/err.h>
>  #include <linux/ctype.h>
>  #include <linux/processor.h>
> -#include <linux/dma-direction.h>
> -#include <linux/gfp_types.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mm.h>
> =20
>  #include "ism.h"
> =20
> @@ -296,7 +296,7 @@ static void ism_free_dmb(struct ism_dev *ism,
> struct ism_dmb *dmb)
>  	clear_bit(dmb->sba_idx, ism->sba_bitmap);
>  	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
>  		       DMA_FROM_DEVICE);
> -	kfree(dmb->cpu_addr);
> +	folio_put(virt_to_folio(dmb->cpu_addr));
>  }
> =20
>  static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> @@ -319,8 +319,11 @@ static int ism_alloc_dmb(struct ism_dev *ism,
> struct ism_dmb *dmb)
>  	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
>  		return -EINVAL;
> =20
> -	dmb->cpu_addr =3D kmalloc(dmb->dmb_len, GFP_KERNEL |
> __GFP_NOWARN |
> -				__GFP_COMP | __GFP_NOMEMALLOC |
> __GFP_NORETRY);
> +	dmb->cpu_addr =3D
> +		folio_address(folio_alloc(GFP_KERNEL | __GFP_NOWARN |
> +					  __GFP_NOMEMALLOC |

Personally I'd go with a temporary variable here if only to make the
lines a bit shorter and easier to read. I also think above is not
correct for allocation failure since folio_address() accesses folio-
>page without first checking for NULL. So I'm guessing the NULL check
needs to move and be done on the temporary struct folio*.

> __GFP_NORETRY,
> +					  get_order(dmb->dmb_len)));
> +
>  	if (!dmb->cpu_addr) {
>  		rc =3D -ENOMEM;
>  		goto out_bit;

