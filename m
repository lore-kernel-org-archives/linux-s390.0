Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851260;
	b=QvWe+M0AhTwXqqfhvZGMhWfk4nFdfQsLsf8ZNSd6L2iNSqP9mH+PKW7OG+Z2JrgobqRi
	 wB6cqHJNQtyRPylhyR26HukZ7vMdFZx6qF2d5C0ZSslQYt1JOZe3NKzUfnu+9ob3O1QWW
	 mMbvCnsDY/KNn/0VUa9e+43xAXvX5D0QIQviY3dUTyMpYOeProlfhRquyYA5gc5xFIQxi
	 Myg5qct5nBLrgKltuB8/65BsoBoA1BpEX2iM5l91R406fW0ehb+U76QLvavMM7YnM6YjG
	 8CqnxR9l+IK+iZ7anBCNNu84YkmU0vOJyuBMJ1fi29TRMbOfQq8yAITQKOqxem85dAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851260;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lSkurEuqzWY07J42xz49JInftf8xvjfRIqM1YL0tZ5c=;
	b=nxJdRvmeveIUOdZE684M97ySmWVvwA9gbem2k4xAoWl/7mavSAULiQjiQZvT1nHnx7Au
	 wOMoZ97+gP0b4BnhtMQJllCHXbmDDk10L4tPv3GwjwnUUFp2dXkXvtbgU9UDRs3ba5Gvv
	 Kw2iENIwSWZMBhx2Y/WHVzzmeyGhb5E9JycuNXoTy63M6OTnGPZpoUXgEoKFt4CEsBuBi
	 NRKrX08UnZcPVbbz1ou1Jrqsfxn0piP4FiqwMLJLAdOHYCWdsg05SA+29WDVG5zuvzbHZ
	 oPwCw7L8uOT0Y6SMVR8ECFZMD8rA+8bJnI5mv6DZ0aSE1Ke5esuRzLNafdf/cfKMWmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rwMGbKeg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB3606A331;
	Mon, 16 Nov 2026 17:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DFB3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rwMGbKeg
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQBjV3773693;
	Mon, 16 Nov 2026 17:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lSkurEuqzWY07J42xz49JInftf8xvj
	fRIqM1YL0tZ5c=; b=rwMGbKegakPvE0CIQtAqgEn+oh3LlHxF+nvZRS2PoVXJHB
	zJuLlPoWa/NHFe5JbYkg6HJkEBQKeCWrywf1dK+v3njdnWn1PEtC4vFDkc2oKZ97
	A/s9d81Aih4CUM4G0010EbH4iePu7mAgJYFvneGj/dwQZv+sYcEI/8kaGTCSG/sa
	0YJ9vpkRHOPuwIoR5bacd5JCzp5YS80ymccJRNeDhPUda5t+VzHrad+mGzcFXScK
	DpHlbyfA1ktUGm63n2aNRyQWBqGz07rDFX4216ag3+Ac+hK6ISXXeqfJJtLhFqjP
	2qM/vQzFGni61Y69TVyy9OPyEMKi7wHqwC+KB9sQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9ve8d0-1311
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:47:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCKXv22351239;
	Mon, 16 Nov 2026 13:13:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bv9u55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:13:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGDCwLW53084420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 13:12:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B526220043;
	Mon, 16 Nov 2026 13:12:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 434472004B;
	Mon, 16 Nov 2026 13:12:58 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 13:12:58 +0000 (GMT)
Date: Mon, 16 Nov 2026 14:12:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/5] s390/vmur: Replace __get_free_page() with kmalloc()
Message-ID: <20261116131256.125125Cdd-hca@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-2-3db507722530@kernel.org>
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
In-Reply-To: <20261108-s390-char-ready-v1-2-3db507722530@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7AiCKN4979fldUbYW-Neq7KI7iaDNVkX
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb41b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Y6TpkvVB5ZIwULgkomUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX5TOywkPDj7lQ
 HNrmfuLln6FgDAm5tONoVF0myIyvvgTGjKb2TaA8+KWG0MI/i7Rr9lWiIOb8/EKtsV4TlffUA0Q
 PeFcv79OZg2atJqk9oQfW5lLLdvyYaL3gsKWTOl6CyEizeBKqFlULaTxTdGlZux7EIwbJ+Y1Fsj
 FNBUuYcKwgtTb0+irzTRS7b7MVAkqDJxaEZy3onXIMI20Oc4vX800/etJ+kY8nlgxgl1qk52E2O
 C6C3LfX/UOWErrxoodoRokstcA8W5xQvUYWaB111dTf0EFwacVWfbuu2nlCpqb9oeONp8bdjFFC
 lAZzjc/N01SzKaK2DSIxOpJUkY3pSOczCzrqhBEgvVdqMJIwlLUnSicUiUmOlyz7Cv1HWQ6MxJl
 +/Rb4NP1mhsW4w69qOMRCKFxdDqPx+D/K0NG8POO9nMNykMcpBzkcUxzL9vhGB5ssWETrHaU1lc
 ielt9eBk1RF8wfvpA4g==
X-Proofpoint-ORIG-GUID: 7AiCKN4979fldUbYW-Neq7KI7iaDNVkX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX/oHTORHLiPRG
 spGtUexLGQ2GCSjwYhnFHs/FNuOQaz4quf96OKEXlzhWJe7LE2Cgwhjp1ZZSO1Xu58OczsAdxLi
 HKBfiPs3FW4s1seTCiNkygpH8TCORJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160069

On Sun, Nov 08, 2026 at 10:48:59AM +0200, Mike Rapoport (Microsoft) wrote:
> diag14_read() and verify_uri_device() allocate the buffers that receive
> the spool file data returned by z/VM DIAGNOSE 0x14.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/vmur.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
