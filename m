Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932605;
	b=CzhnO6P9nSyPBMJjqjW7pD8u7eZCwKacrOCtGUy6N+uvHBjDQcM3VQAjmQdkCzX2WCGO
	 BOqVwxp3YIycmq7vwVlGMaMtvfswPxXqK7aa2/Qx4Bd40AJcf973fNB2PI6lQMLTTiLh7
	 4lJEQy19R11NVt6zKoatSRuWVSPa/OOhVDNTvHu4Ad66bp0nxoFAwyZU5pJr65XrdBaTI
	 8wkgMvfL29amNUYo72Hod9oJqts6PnaPFXlVBJ8tkEcSF6gWvRD9bD0SMFfkVtVSswLgl
	 nIm851AZdsBXLjTBA6in/M0USmBY/tonzLoLcFb2vMSVhwYGGo/R1mZsloLaFys5sRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932605;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T+fC7kKVmyHEZqOON/iU9HV6zzmhyZtzPZO5LuCy1FE=;
	b=L63oFNwswx1uoweCW6MWVTLhh4TgSiS8W1lkhogg8olMW6mfUAKFvymJIaGpxGlwYBso
	 fHIc1+A40IFCcxrnkW8r/Mh94E4TX+LKk7eYv/yKnuh3bxYcolaFLv6oPAvEM7FR+3aru
	 CAlq33bIQw2vqS69Xbmy25g9IhYsoXTe3xkBrkMemhuVogjINWJQgA9lRHeVqtqfsLp8t
	 T4el+yeKA/EqQz7xMiqIoZaW+rYtLmFBgh7i+EcrD1UJipyFwYlfGx6rrQAp3J7/OUDV1
	 XihITsmW46sC7DHnoNloU7mhoPKjyY2aMNAKc4zcvJ50eZft3xLFUi7eXZYHah+x9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMZEQGc2;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DB606A32C
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692DB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMZEQGc2
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQcs12892686
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T+fC7k
	KVmyHEZqOON/iU9HV6zzmhyZtzPZO5LuCy1FE=; b=PMZEQGc2bnYGWrlgO5V2UW
	4sr0l8M0chRAB+VuwVJ4XHTyixRkaasbqL15hPCFCF5Zftdco2fkdadrVyeQg62k
	WAA78iY09XPqxNAYJm2rfQC+bxtAz5UfcMktPk8yp5/iK7+HBd4+5ma/8Q/pEX0T
	nnwV786JQXArO/r++5xPnqZ5gStzaJ50HnzU3zIiL41HkP5+nW8M3V9QEnQRuAtU
	+2jo93m6DhGHgahkcAyYb9vk5zpircEDfyjd8u/+9y4IFcHDW4aA+5IPcOxXe5sV
	NtwlNq1RHw3hiagH0IyWxqctBQd9EsmNLcItt1+TFYcqOn81GgCi7AVMXotr6U4w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf56c9qm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:23:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYxLj3749415
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:23:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ncdmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 16:23:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHGM4CT52560316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 16:22:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ED772004D;
	Tue, 17 Nov 2026 16:22:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF7822004B;
	Tue, 17 Nov 2026 16:22:03 +0000 (GMT)
Received: from [9.68.31.53] (unknown [9.68.31.53])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 16:22:03 +0000 (GMT)
Message-ID: <47f5f00c-e3bd-40ae-93be-65d4a5f2cc21@linux.ibm.com>
Date: Tue, 17 Nov 2026 17:22:03 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH 3/4] dibs: introduce dibs console peer device driver
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
 <20261008-console_server-v1-3-636b11ebf191@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261008-console_server-v1-3-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX/pf+Ou26o7Go
 //xYn8bYcMAowZLxU9s2ssOKWn+qMDzLr5vr1049bgqLsoo9nuABu/e2CIY4Ri0HPIRLekkNPQv
 NJXnIQT7CsoR1SeRsgEAB94gMMPZvU0=
X-Proofpoint-GUID: IdgC8tMo8KXVEaHikmroaVErgliTUcyt
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afc7f7c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=DQchAjwAMX6vclSPPgMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IdgC8tMo8KXVEaHikmroaVErgliTUcyt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX7fVPPzAO28q1
 0+uAlt7WtOYhFxUEnwNFrT+Unt9zSxMyTs4wfLKAUmzzaTX+etutljXCy6BJqW3ZZQXN5zt4zrG
 c6U8BF9hzRV3R1LBQXpVqTtM5j+SEShqVh1CJxV+imsiqFiYx6jckDpYRwA/HpQFRr8p7WBQlR3
 zx+uj7ok3522q7FV6T86p3x6pIdwJZeeWQ4jV/0EdtVraEtyDpDD+GxTz+hnwLeRgFzJKegVE3s
 eZKV5NMg56yNV2/afnYbTHG1n/hxDx2lLPlToF+mY8Y7KUcilPNBfc6L7osTnNFYhj3B2iBHuPd
 jkc4KvDGUt1iUKhFW7gZOY1qcN3P1Yy1qOrJ/F9bHgyz54P8pZQMTItB1b/GnWsrIoT6FopAGK+
 VRvj9QdvpxJpH0RMz81RrzBIcFY2BRYnzAqj+9rfl5uTGNBxEMzW7Cl4ZKCSdYV0OKN4f+o7ziT
 rmuo9scBr08Xnf3vM4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170063

Just a few comments I noticed. I will continue the review at a later
point in time or a future version.


Title?
s/dibs console peer device driver/dibs console driver/g ?

On 08.10.26 10:08, Julian Ruess wrote:
> Introduce a virtual console device driver that makes use of the newly
> added dibs peer device bus.

s/dibs peer device bus/dibs peer bus/g    use the same name everywhere!

[...]
> diff --git a/drivers/dibs/dibs_console.c b/drivers/dibs/dibs_console.c
> new file mode 100644
> index 000000000000..df53cbcf2fb5
> --- /dev/null
> +++ b/drivers/dibs/dibs_console.c
> @@ -0,0 +1,388 @@
[...]
> +
> +struct dibs_con_peer_dev *hvc_peer_devs[DIBS_CON_MAX_VTERMNOS] = { NULL };

I get a compile warning:
drivers/dibs/dibs_console.c:88:26: warning: symbol 'hvc_peer_devs' was
not declared. Should it be static?



