Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614387;
	b=1bZwKo/48YKbEd01V54GWiQ236gfR3S6i8EeXy9tv3pFJlmrGyBn+mOiT278FU7+VO44
	 VvY8sx6hx7O/1PpUOdnqTAHRsOAR7/LdYhmEcipYXl+8IA7IDqtGDNoEL0rj8UTocfbXB
	 Zpnnb7XyQgghfl7dD7SV6NjnVQ4aqgljwBRqNxPzFluDa25zCpZP1EbkrYjTKJrLRcWxE
	 cr8yoemSqyLe5nJK8aKTO9jOWx/Zk2VxnCaxVvLUDqMcGAvrNIzZ61bgaxUN4438MhSNb
	 wqeCeXpdFJoHOwgUwpB/Gnnh2MeD0CAQ6BWWz8i4DLlNkH5erLydn5n/PKzzfy2MroQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614387;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yI9ETbLZiGkZ1PIenI8hYf34x5l1KL1WOI/mwt8fqfI=;
	b=e6z9aNibjDneWgE+3GR0/YYKIKU8vb1sdtgfE/5Q9sslVaHSHr1LpE6QqoJLZeQNHsWj
	 Qpg2NjGOABwI5adBp5AA2mmJx1YMEI3dgKDOF5EtCa/rLg0t9QBUgdOH1uzj+Qg8z/NN+
	 mX7k376EjEd1BKct1uPoRce01t6zCIHF7xM50TFJqDCMSGdOyFSVw6KRPiZGkDXwvruNn
	 NtubnQpJKseJ5vTPDGEfS6omuz7NSk7WmVuuafG+qfYnDtcoXFywZ4SmF57/sPWIuIV3I
	 yJQH4V1UA/4GtYql7OXEV+/R0mOwwI+BfBmk/E7yxS4xnbne1utu6505ZLmsy4w8rIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eyck3Tpx;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC53606A331;
	Mon,  2 Nov 2026 10:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBC53606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eyck3Tpx
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29ERni1334231;
	Mon, 2 Nov 2026 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yI9ETbLZiGkZ1PIenI8hYf34x5l1KL
	1WOI/mwt8fqfI=; b=Eyck3TpxudnvOAuxGX+aeomS1QVVPSsSDCqdtaVifxLm0b
	9dOQ3G8UyHEvp0l45R9RUu7k9u62Tcuw364Tub7ea48SO5mrMFQDaHj/MRNVkxNl
	q/4WsCmMyEXLub2MZGi2SG+9PQWJibX+nNCO4s+YmmXslKEB8Oi7UCT6G8WJ1r3J
	JmE1xYNCBJTH/vjx4HoFj96XE1OUsMyS/GIrK+WrRu6dWK4xoUeOFJpR0ZnrfZP6
	v6PZofjxdtw23Y9TgPqxaEr1kLCTa2+xc0C0yfXw0aMcjTw++8ZhXi6/SGkN6f0Z
	SWYJimQSlQb1XkLUKSbzQlk6sHQeTwTzMsu0VZ/g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rcyx29-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 10:13:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29K26T744393;
	Mon, 2 Nov 2026 10:13:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxw1yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 10:13:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2ACxmF45744474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 10:13:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA4920043;
	Mon,  2 Nov 2026 10:12:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BCDF20067;
	Mon,  2 Nov 2026 10:12:59 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.138.96])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 10:12:59 +0000 (GMT)
Date: Mon, 2 Nov 2026 11:12:57 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH v11 5/5] vfio-pci/zdev: Add VFIO FMB device features
Message-ID: <689e23a6-dcbf-4fee-bdcf-13d333db2e85-agordeev@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-6-oelghoul@linux.ibm.com>
 <20261030161146.5af10847@shazbot.org>
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
In-Reply-To: <20261030161146.5af10847@shazbot.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ndDsZI2lgL3rn1GVI79iu_XZLq5vKVuH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX4O9t8Ltm7VaO
 6wlDc1o1p1VWlKVCHXFC992bJ3DU8L9uCL3J3oryNzL7FJ0FfvhjBuce5f3oD/ttLCDLRx4q7A5
 nHZgQWqxP0vOK0EvcZRT9QL2PY09KNl98A0XhaMPynz2lhLf9sQz00QKxGNwegzyVcaxDZxIaUf
 645ZlCfxr01RADm+aWdf9diYwOEVJ27yLpdkfOcEU99quO2NS//WrHYnagLgTVsU6ewOPSZnoDl
 69YXMjXJxy03lZkhBqMN/xt0USfibhfhWr9ZIC7YghmxSZ0A8hDUsoP/3oVuW4t3f1EmG37K2Iz
 xXWa0cq0WtZ/I7rTbEvbQJoAuadY4oopIRy1AgTyCEwN4fq86it2F4n2hVJXP8KQSIbiujmVbzf
 BIPPYwXWYSeU1owj7FuA5pMrS7nYOP3409OSWmRQVZbV00TF5HJuP++YOF/cYXplYpqr7XF5rf9
 wA7lOyfr4CeacH8LgUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXwtTLxj+hPKvk
 kxUn64w8otQSiJ1jttlN3ac55RTUBeN+9vhcV4jA5OAFNwic+e3lwSgulzAp0oKaV7OWHIfLQhg
 wNdsEZoroCmPamSQSH0Iu2tkagg+Hpk=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae86230 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=kbR4MaXf9azrtOfwTQsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ndDsZI2lgL3rn1GVI79iu_XZLq5vKVuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020038

On Fri, Oct 30, 2026 at 04:11:46PM -0600, Alex Williamson wrote:
> >  drivers/vfio/pci/vfio_pci_core.c |  4 ++
> >  drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++++
> >  drivers/vfio/pci/vfio_pci_zdev.c | 64 ++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h        | 30 +++++++++++++++
> >  4 files changed, 116 insertions(+)
> 
> I think the only thing we never closed on from the vfio side is the
> merge plan.  If this goes in via s390 I'd want a topic branch against
> rc1 since there are a couple series floating around contesting for the
> same feature numbers.  Thanks,

Hi Alex,

Yes, I can create the branch once all patches are reviewed.

Thanks!

> Alex
