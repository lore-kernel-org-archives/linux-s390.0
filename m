Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929603;
	b=pCaynlj2trkdmXQu+/EkOwBvAj773jb4DL4rVl5au3/XzOt6EQ7SRQ5fL+Q9g+oeqhji
	 LR/fyOo7ktVkpPzP9ubZznGWF2tYKuW4q8/M+IN7Tj8twqQ1chRIR4g3XCk9bwvxvsyeq
	 m9mkZNDxTtn75pj7bLw0RaNonsQDK3irwyqSPSdpePROIhNCYRfXJ0oKs2g54lacmHczD
	 /Cx/WRfxT31vNQ6++j+B+dnkTksUJW3mCbINErM8g036Ce1yF768GJD0PzecYsPWfU/Vn
	 gZlBRr3YgKMy3qhyFIc5wFc56SXhAZ7WSLGhFufAJuSKR9XR1F8f1YjRml6UPecqzKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929603;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=f/fjR6CwAs3q03u3k/OuMPCkcaJFzpjKdriSKK3suK4=;
	b=KDJ7xiE+ZXjpyi0nxIE1L61J9JzK7JN20kAhR55iqgANElALjWJVsu578AxD+8RccsZ4
	 sUNJ1Lb+1anbr+e2fmSFD5bOLhcZJTkaIX560c6Z8JwP9volMvRCLFXlEYx4iYDTvGvfj
	 6LSIVJvWaTNJxMRPQFE/eXvHRGPKGk9bl0RM3hw04mnNWLT8XEvnU66DshLz3tk2+qj1+
	 7vyv++vOmdWRz13Oay2UZOG6albLxJV7THSdkP4Z0npuThXw33IAFG4ZOD26P7hvACOrr
	 vSQka9AL6lLFDngD9ozYAiBlPNXqNSusYS13JhVg2ptawiodWgnImrDuT6CaRL5zvxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JQWrAeZC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A7606A32C;
	Tue, 17 Nov 2026 15:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9A7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JQWrAeZC
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQeN72711641;
	Tue, 17 Nov 2026 15:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=f/fjR6CwAs3q03u3k/OuMPCkcaJFzp
	jKdriSKK3suK4=; b=JQWrAeZCbPTRiP0X3WbGG+y3i5dlhCDYLS5NZzRNQVAI/i
	yoyYnzlMbQeYk1F0nuCu8cZt84NRpMeq7MDEV3+9A4dnFxcZxPyXkNosA1bFmQnj
	S1rPaCUrnDv1L32h0i5LOJz72I40kj2ehIh2x189IOQoQzzI0BxtvgI5OnPKEDN5
	5TnENXHrNUDnT+IAe8XnNBAH6CGK+6TwPO/tBYTvWBtxs/CK3ix5II5k1h3ri0eX
	T5Yuh/RxzyAGENAlRv6+ycFWvwKMRyv5WtHQW0+wvBjvqopkY4tEOSE0fmE31wpx
	BXl+bZZ696+JMcTsPV+9dxUyd1ASfUYVCwISNU/Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2m3jgr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:33:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4svR471687;
	Tue, 17 Nov 2026 15:33:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfdhwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:33:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFXCeE51315008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:33:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 724D020049;
	Tue, 17 Nov 2026 15:33:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 177A320040;
	Tue, 17 Nov 2026 15:33:12 +0000 (GMT)
Received: from osiris (unknown [9.111.0.235])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Nov 2026 15:33:12 +0000 (GMT)
Date: Tue, 17 Nov 2026 16:33:10 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/14] s390/sclp_cmd: Replace page allocator calls
 with kzalloc()
Message-ID: <20261117153310.32016B6b-hca@linux.ibm.com>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-10-e518c99622c6@kernel.org>
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
In-Reply-To: <20261117-s390-sclp-ready-v2-10-e518c99622c6@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afc73bd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Y6TpkvVB5ZIwULgkomUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UE2LM1lxxkyDFML1Deg6Nq8QGkCrI9fG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX776VWhTK8Cyj
 OrZz9G8TfA0SCnR4DPhv+A4igq4HI6LefuihHMmPhRYfO/fOkRY5+yPag0WxkS6m17AeFufRghw
 mOWRqd/+HNLRfFiFw2CFGVFYSAftFDI=
X-Proofpoint-ORIG-GUID: UE2LM1lxxkyDFML1Deg6Nq8QGkCrI9fG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX6/jvNyvwN8AO
 TPYXKpKuHvlrOrZNnsNozkrng6Z/U//W1MVvDci+dcZ/KUNXIYFPCpFwbtZmlHpTbsaIBgksWLe
 R5xAe6TAwamKQcFb42JTVXf6BnlAUmZaRcM7ELNvBVXSHkb7+Ir1IkXCsgeK5NKlVVNW1GlFzUc
 2wMfVPEf+D4PF8Mldc517LY6Fy0icmLWvsDPq9ASws8pl9kyG6ng+AK7a7EkQKxvA64YsEL9tXU
 e6jz2UZ0vbFqaWua/UTPQEatpVOSkGFkeVtIPql6KzBcXB9KGvZls+51xb6GIPf0yH6OGHRAqa2
 F/EcsBLnbm52CFTvvnDYx9QXXIeHNR7OTg+8bSKiDDmVdiiPzu3UFrNB1IWjH+krS4RdyA9DHaI
 QoIYgtAdeumlJqKvAT+W/KDVYpQbHc245NOitBSg87r+p3In11FmpSBFVRIEhnBBJdGs4Jr3R8i
 a0ru0rj5IfP6yc9E6wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170061

On Tue, Nov 17, 2026 at 03:07:02PM +0200, Mike Rapoport (Microsoft) wrote:
> _sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
> allocate the SCCBs used to read the CPU information, to configure a
> channel path and to read the channel path information.
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
> Keep a power of two size for the SCCB in _sclp_get_core_info() so that
> kmalloc() returns a page aligned buffer.
> 
> Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
> and free_page[s]() with kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/sclp_cmd.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
