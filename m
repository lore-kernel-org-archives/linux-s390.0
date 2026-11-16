Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834986;
	b=wu9eqxP2CwMQnC+YMd4tVTL3H9iTv5MiNjxyB45RNaOmgDzOw/bxoYD1E5dFXOctLhfD
	 zxf6a6+5kjqBVTnh9XeJMIWgY5vhB2LaThNPROYI7TJHpBeVaewlQr3PayWD7GGBCJog6
	 mxVMrcGmWZUUKEMKMDrvPcAUKv0bLkK/OQ+2P0jKiV7o0JEFvlh4so3KBgaJGgfWmmguQ
	 hbB1o/IL+NwqyUfEmkor2J+AOBeDv7LU8+gCB46SDGPJmv8PetokkBETwaPR41el76IwA
	 g7NHoT9nbONWmkoSP19wW8/MGX3FdYJwpDUB+kxrTwy7qkGnSpgwvhBHZAHUwbOsfQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=irSzvd6rW8sUPYLpW1c1dglGknltWR9sWTeBGdFo7Zs=;
	b=mcC2T036OtG2qfd3ZGyBD02ltCdwyer3OtQV1LntgEc2WYXsZyZuGivuEc0kPKQRNiVs
	 Hqms/h+Q62Ab9htqJmEAcF+YB3Owjy39bDOMZCcqttUgjehFUAqIfI2iNMqEvg2VOwfJF
	 r7+7kgHRW5CcfLCS66AdpdnE5PupnI5MNccA4hCZkrSKCgfylTi1x2FoMukJYT29H6wtp
	 yVeF8pyI/PfZ+27aSJc0PLLzq57JyQpAYn1CrgH1xi5kWKqjcPRGsoPXBaiVcCseTKQM0
	 8eGrZfMehRCbWIhILpWuUbleLC7u8/2WNXR+jr2l3suWg0jCptG9inA5+/bfpoE0ZbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CyqEYnvE;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A15606A32A;
	Mon, 16 Nov 2026 13:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A15606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CyqEYnvE
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCQobW3269834;
	Mon, 16 Nov 2026 13:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=irSzvd6rW8sUPYLpW1c1dglGknltWR
	9sWTeBGdFo7Zs=; b=CyqEYnvEB12TBPq/yTRg+bKU5jNT0TfbnSC7aDHu010ShV
	wisMMh5CaheyS5e6R51Isv16+BOWKykY3tpjyYFZtar0NbACWxYtFYa8co6lj4Eg
	+sAEiaPphJCBY/OGllcb3lQ9ySmAn2lJfGWupM2TbRTM7Rw0Y3FyU7Hb2UO34DfR
	YUMr+7aAAg/w3gxLdFIv+ksqjbvVYYzZYUqx+VZ8QlpG6XRFPi45QygifBfk53/7
	8duwEcdPxUSGcdR5svEcuzOEdwNu0gh2yBL5YNVNTol0dDtWip4LR7uzYYXbb6+k
	juF0Mcoe4vwaE5s8dSEHXHpuzgCBworkqxlPPbLw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9vdaty-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:16:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC4s8K2972461;
	Mon, 16 Nov 2026 13:16:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00ns8nen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:16:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGDFV1645678852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 13:15:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9952004D;
	Mon, 16 Nov 2026 13:15:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB5D20040;
	Mon, 16 Nov 2026 13:15:31 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 13:15:31 +0000 (GMT)
Date: Mon, 16 Nov 2026 14:15:30 +0100
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
Subject: Re: [PATCH 4/5] s390/uvdevice: Replace get_zeroed_page() with
 kzalloc()
Message-ID: <20261116131530.125125E49-hca@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-4-3db507722530@kernel.org>
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
In-Reply-To: <20261108-s390-char-ready-v1-4-3db507722530@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i2D_tlpxr72T_N2LxoY17nVBjcw2IKaF
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb0216 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kt7I_EveaTZZBW9BUTwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX3O4PszTN79kD
 V0RMgSAt7OwvlsmoopAqtG6ODelN84sy/1sjneuQ/8EwrwqaxEZe6PAPYAyyLE49CNx4XLJcIYr
 goehKRvFg65rQ3WNlGd6hBmhuTRT84gNgkXFqgjdMqF/E2gHZkpr7K6XHJuKZXzb6d/+YHBU6Lu
 EyveSUg4mQy35BQqJdEz1fWmpw/+aL9iw/bVcu0QSXbfgT+7uzq7RhWHZP7t+a/JFDrutFOs9aG
 Stvd+9yamdskQjl614XMcN98BOwrUrqqL6ZOmBpCTfWLlhlPBahu39sy6LyV3b0t8VlJQG91nbs
 2dQkoBpWK1CzSH4cTTKDAqbEmandMNirqqqzJ5qb2qq+J9pT/FQwCP8yoQyH5H0svvLYsBeGnZO
 gbLapLF5nwkPlATl021ol+eXZButHXopy78RFHWChM9uz+ydtCbDyDMZOo0ursduQhnGyYlu7gj
 RksWth9Xhpn+UcRp0KA==
X-Proofpoint-ORIG-GUID: i2D_tlpxr72T_N2LxoY17nVBjcw2IKaF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX+XgafhIJRVE+
 2QE73nd9PQoM3KUWBx/2ilhF4/JLt3Icgq2JPrwC9SfT/zz/lMJMOrUBL9S5zjY92K3M8QqICm2
 WHAQGA16oHKLrSDtPVbdnp4UYvzLS8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160051

On Sun, Nov 08, 2026 at 10:49:01AM +0200, Mike Rapoport (Microsoft) wrote:
> uvio_list_secrets() allocates the buffer that receives the list of
> secrets returned by the Ultravisor.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
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
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/uvdevice.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
