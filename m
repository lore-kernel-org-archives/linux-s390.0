Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110113;
	b=LZXU+LF6ow2Fhj5Kcz42m7M3B1daQIRix4MpkGLW6jcdVjQEDkJGYPFtkjKcvJJ0eYEE
	 zOkrZNf6cPoNANTXg4ScFKpz2plIUXDAkNMZ69KJcHuHkw2X4QBHC+lOWMRf475V7wOX0
	 kGQdujGVqKu4/SFqew+N5bDp/L6dRhsZZROIrToB7owUDzw7r4A6xqTAAWkFTIaSOm4Z+
	 MLL9iUdYwZb1wfhJUMjAQ4viShGOqtO1STlKuhVLgbBuNo77eTFouGUj191379MydQPVB
	 yLMMgGZMpvcmUpPEI/pZVkxm6cDmKtde/GFUUt2d4NcIMvLKMF17uJIhLRQTuFE9Y5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110113;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2DdP+FQjqenjSYcKVY1xKs03VjAkLGGa1B6720u0ouo=;
	b=AQV33UnbkGH6Cv6+9UhfFfpbeXXTm2mtFXF46Ql8ywvkNVOqbc3pBtnf1T5KVI9c40Tu
	 WvYncnLcEqP2WE4sljjT9Aui/KZhKm2G4B6pN85WCkmdvPTEUrYO97qjGdG+F6RCnt/MG
	 a04nOlxolbmS8gN3ASIXiPNhWF+O5Cq0HXLRXZLXcaZeX6VyigRrjOp4maf5gNEGQG3eh
	 SOAjyk1ln2aWcUyb+JtRuXX2GOrmV5Qt8ankwKRHrY1r8znhygs7amTQtvPxElDHYAHVr
	 PqevxVO+ZOG1XF5+rhgKUS4kCM/5VGHOK5Zv9lD+FpxXBaQuLRIQ4kWZnWgA5QLYTkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XOaZOaVG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3390606A326
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3390606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XOaZOaVG
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5i5Ko1621777
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2DdP+FQjqenjSYcKVY1xKs03VjAkLG
	Ga1B6720u0ouo=; b=XOaZOaVG7j0clSKylBnFL1QA4NXfYz8B30ODUDJqcUS8zc
	NFZ9wWYUyb8hYvAQDS3wbmGJbIytKg9ZfYALKuxOv77k9rE/9GVOy9epvtBI7fZ5
	U8B3vhwM305A1uIau+oNGOVcUTTB3L4s4el8zIe8f2dBnhSNCy1oMMHOreXRPLvM
	AuDn5d33PQ8g81yA4SOgSCGOgxLhnRusT6Fn+ROTcp1PTUX/0ZvGkXyqVtBiWBP0
	HXZpy7hPoaF+ua9VKNT+y6XaKT0ZBy7fuaSnZ+eWA9rrmHYlHtFapL9PjNdHmFGl
	pSWGH0xrFn4jK3zjkGo0aTw1/Kclc9A6a+sx+zNg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63yurs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:08:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoii9053900
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:08:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7rvr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:08:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RE8QNG49676788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:08:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DED0220067;
	Tue, 27 Oct 2026 14:08:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6F482004E;
	Tue, 27 Oct 2026 14:08:26 +0000 (GMT)
Received: from osiris (unknown [9.111.40.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 27 Oct 2026 14:08:26 +0000 (GMT)
Date: Tue, 27 Oct 2026 15:08:25 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] s390/diag204: Introduce diag204 rework
Message-ID: <20261027140825.11789B74-hca@linux.ibm.com>
References: <20261027-diag204ioctl-v4-1-d5e90b56112b@linux.ibm.com>
 <20261027113242.11789A2c-hca@linux.ibm.com>
 <777a0294-2729-4389-a98e-b07fe0f4ae2c@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777a0294-2729-4389-a98e-b07fe0f4ae2c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX/1/NgbzTEnef
 Se+AIfoetYm8HpcHytwqKKHg1TvSj4tA7+CO+NF+T9hEtZWs0J3s1SW6/9AH/Hqv83ZDac6DgHS
 MGqyHJbQCaqn9yg5hRKV41l3ZGzvLTc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX1VxM0alnoeNd
 g6MKIJ7Mx9jXiA9MjRBa1t57mP7AzE4eKbK6ATq4dsSaFPHbpIuOALigjVo59bCYcB61t3qgusQ
 8r9qZzIy9pj6iXi+ldp5fgrqxbGMWZHZjhZnYwc28nJBHsq3NWoJGQvnrmIThAjha97ocfug7ER
 2zHGpFY8hA6+yBgeznG1PM/tlKbC4PilGWdIhFVedkt38NLiZAe96PF8S2MmAU2fQps4dVXCTe1
 Zf1AiUzjD7UkHG00pLtnmuDLakMKmsnGhYY4j0/z4dMzywu/pzyrhUnzuXcuHHCFKVXEILW+kNn
 dgGjrPYlMMWzIgMcCwMEDA3EBQH8iB+MTbCsjeTCk2XzgnArOsryB1PseX7IqDFQvSNxd6lH4vz
 HaV/hWIPxkODwpWtdBChEJZEJEEXQSDWPBj8DKsFmSrCtFhfTxPbXBSbZ3/8DKlNCIUR3+bWsKa
 LFZmYcXzFyzcI4V6PBg==
X-Proofpoint-ORIG-GUID: GIHUL7O2qZwM7fKJLWS_3Fyv7ux-akWP
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae0b05f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=cGL_shwQvlvIZo5zzOYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: GIHUL7O2qZwM7fKJLWS_3Fyv7ux-akWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

On Tue, Oct 27, 2026 at 12:53:22PM +0100, Mete Durlu wrote:
> > > + * diag204_init() has to find out, which type of diagnose 204 implementation
> > > + * we have on the machine. Currently there are three possible scanarios:
> > > + *   - subcode 4   + simple data format (only one page)
> > > + *   - subcode 4-6 + extended data format
> > > + *   - subcode 4-7 + extended data format
> > > + *
> > > + * Subcode 5 is used to retrieve the size of the data, provided by subcodes
> > > + * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
> > > + * to subcode 6 it provides also information about secondary cpus.
> > > + * In order to get as much information as possible, we first try
> > > + * subcode 7, then 6 and if both fail, we use subcode 4.
> > > + */
> > 
> > This looks like it was copied from the old code: please fix the documentation
> > convert to use imperative mood when you move it.
> 
> Will do! Should it retain the details about which subcodes and
> data formats can exist together?

Sure, I don't see a reason to remove information.

FWIW, it would be helpful if you would reply-to-all, and not only the list :)
