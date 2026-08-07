Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E0431A31;
	Fri,  7 Aug 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102140; cv=none; b=MK6WyFxBsDXWCOEqmzHC4LBt7Iea1b4SHoOkdhUg1c/XDgoyDBnl2gD4RxqnHxxvpLhXPVB3UDUb2hJu9wMclUb5u8GOZAKJlYz1sPP3pQ7s7BSRQBoa4+Laa88fuyLU6zWtTaPwCsfpRfRs7l8nrPS101w1DhKFGSef0VLD5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102140; c=relaxed/simple;
	bh=PcJABLzpoDT2DIi/BIpFr1iR3mnHXrwIiUYZ0KOtH18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRVeoxeI2la8oVLR4gCyqzlF5FZVBS6grw3mpLRbvdrlw8Fhfk1DtXMUvNk4IE6fnS6TCPDsE3oR8db6HhlAtQMul1NTxFILd8/Hrbqua5Eda+V85nDBSEzYyBalSAaYJGB91fSQTXeVh+nWRudtU902sSCPWwdaBWcN3B6h4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lWrPySbV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lWrPySbV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hivm2276155;
	Fri, 7 Aug 2026 11:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TSBtpX
	F0YF2LAChC7VkLS0bTjD6+lp5CLtRAxRguNfo=; b=lWrPySbVYpIOC9iDumBfa3
	oXLywtDVJ5Acn6SJz4N4MCkvu7roQmoPXlw1/qaGyRSwwuu5vhl6fanpAjypLNHa
	avT85POu/kczYwNpulfbXs+l6u7gMZJUlNHdle5sQ+uqCTZRjfdit0lC4WHZU8dQ
	QYQUGlhjJun4ZnCMGcrWWe6mOFMuqty8QlJuJ4gQQbKTODVJQQ36Y9YU/X38M/Pd
	STve/surWt/f2LJHcNQnOiHYO67LJZrOFSXEvsr6px8SrNPeV4VZWs+vNNETaw8G
	aFfmNpLw5He4a+OEyBdUf5Czp2GEYovJWJtqZrq8u3uPXjJGwKOhSV206zUbtOiA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01kkur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BQO4Q001719;
	Fri, 7 Aug 2026 11:28:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwfjbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:28:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BSpjr30474668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:28:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4162004B;
	Fri,  7 Aug 2026 11:28:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4556120040;
	Fri,  7 Aug 2026 11:28:51 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  7 Aug 2026 11:28:51 +0000 (GMT)
Date: Fri, 7 Aug 2026 13:28:44 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: s390: vsie: Convert shift to phys_to_pfn()
Message-ID: <20260807132844.4cc87356@p-imbrenda>
In-Reply-To: <yt9d4ih6rxz2.fsf@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
	<20260807-vsie-cleanup-202607-v1-3-b18659b55e3d@linux.ibm.com>
	<yt9d8q6irz6h.fsf@linux.ibm.com>
	<yt9d4ih6rxz2.fsf@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h8CGQjrSLDnZS3Y_Ym4SoKsa-vVvIkK7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXx0oOobNw+HMZ
 UuXaRowNXf7n4TXMMVRbe2Gzy6sgUhQ6akvGHZyTO0QqCB5cwvl4rpAQkK1Fkbij7SV/G3y89de
 8ar8njMwNKXeZ+J1u12HgnQh2xJAxXk=
X-Proofpoint-ORIG-GUID: h8CGQjrSLDnZS3Y_Ym4SoKsa-vVvIkK7
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75c178 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=gquMrDYm1F3yBrFt4XYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX0BAif8W5k3bM
 jy4j1+8txlVUYJnIqZo+E9al8dV1C7OBinQDn6YgsNWLj24/UcmFao7/7nKZrK2Gz7gUPGKBvO7
 TqcgRhbTmNm7lWDPfKFRPzwkxV4HC/5EXMG5e8C2WD2yqtuLHgqV8z/6n0ftGi/jAulEBlP7oDA
 frde7RRj9iBjfNAZzOZi4PQKdenAwoXuPFYaQpNAS7KULSr1WOsqcws/eeA0wOBfYHKlv+tFjiO
 G5XAjSDuhY+SQjkeMC43pwBivk7qyt5+lP7XXzf3P9DNo8JcuxncDd6XMkLk2+RMbUUgGDPyo56
 lEQ7TTdBiOaLo0LwFE0ySMODEhQjVG0f0t+plEr4xpj3J7Pqk0Yh0Ag4uPlexotiBiPwvR5qU/u
 HcAQ2CYEnA9n6/fxMWdYWU66MgC3losB2GtEDxm88zk6ZIM/q/aOfJ+zaoKlSPQUARyzQiUeshr
 kq0BhrHheRDJdzXv9vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

On Fri, 07 Aug 2026 13:06:41 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Christoph Schlameuss <schlameuss@linux.ibm.com> writes:
> >  
> >> Make the code slightly more readable.
> >>
> >> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> >> ---
> >>  arch/s390/kvm/vsie.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> >> index 3e956c7faa4b..937f9c99bc00 100644
> >> --- a/arch/s390/kvm/vsie.c
> >> +++ b/arch/s390/kvm/vsie.c
> >> @@ -701,7 +701,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
> >>  /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
> >>  static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
> >>  {
> >> -	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
> >> +	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
> >>  	/* mark the page always as dirty for migration */
> >>  	mark_page_dirty(kvm, gpa_to_gfn(gpa));
> >>  }  
> >
> > Could you add to the commit description what you changed? I.e. use
> > phys_to_pfn() instead of the open coded shift? It's bad if you do a 'git
> > log' and get commit with useless descriptions like 'make code more
> > readable'.  
> 
> Nevermind - was in a rush and missed that it's in the summary... :-/

I still think the description should be self-contained and not be split
between the subject line and the body, even if it means that the body
of the text repeats the subject line again.
