Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713513D5235;
	Mon, 20 Jul 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540442; cv=none; b=RadmKaRjgZfe8wCVaqeDUP6N+vVCOzlgjve5CDA+a+670OV4bowQkuQ6wD0zlXg2wgiZw3cMwma0bTvC4kq0yFHqaROodMiO83M9PIlXgA1EJKzy47YYn5dE9h99jt6ymKfVwJZDNlLuFqmjXzWGf0J1KkEOyOoKzhE3la+efm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540442; c=relaxed/simple;
	bh=mqoJrxlXb7YFug1RYifbXS6Or4tb4+lRXpOTt7fBlho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRmpdVCEhERGzFpTaCF3DKXMraP1mSXc+a4RTBPcFPzUz8PRtZyjeUHlmfUvVZd0z1LSiwvPWNghRQkQjkBiRKdhVn/qCiFy9UctaaL/ajJ1CBGVXgETeAM1gce2c47zNpkFwYjD5b1D4mwStxDa77heoBhsip2o9FI9AHy6GR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQQca7NW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQQca7NW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6g0lR1462048;
	Mon, 20 Jul 2026 09:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gQuk1IoJohMuk4LWv4aU5IBueaHbJ7
	DbUgvwgCQvnuU=; b=dQQca7NWx/0B9YqPVsZPmzJ6Rux/XwEJB7REaykkaV+eUO
	tsyfS0rw4GXAowBght/CN6NTfveGeU6FVwhb2GmHQ9qtHOjEDf4uwdtCGEpv7gAy
	8E4e/h+dxN34vopNxPbb16QIasKy3w+Ar9uhSCKJwL8B2DEUtrCyn4L5DJwIAHYD
	m7s1J2Hj9WrScnsnWim7uTp/g56VGwU4iMBwen8JqGJKwuAkYXTxPEg7QfVoil9b
	gIFapAVaVpaAhhwwAmkyQrsz2wMnEZENXdLaxJ4SN5vU582GVTdnUkLWQAblVYWA
	nSlB+/ekqNBrz9pdde2v5CMQRPUNtzcS9NmAlueg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab6t6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:40:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K9YdK6016161;
	Mon, 20 Jul 2026 09:40:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4tn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:40:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K9eYVW57016624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 09:40:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF5A02004F;
	Mon, 20 Jul 2026 09:40:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C9020043;
	Mon, 20 Jul 2026 09:40:34 +0000 (GMT)
Received: from osiris (unknown [9.87.157.35])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 09:40:34 +0000 (GMT)
Date: Mon, 20 Jul 2026 11:40:32 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] s390: Reintroduce support for DCACHE_WORD_ACCESS
Message-ID: <20260720094032.15865B67-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <e1660375-1d0b-4948-8abd-aa336bc5d171@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1660375-1d0b-4948-8abd-aa336bc5d171@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMiBTYWx0ZWRfX57dmwheeXudp
 YmFSGpshLU2w7hg+nc8oHd8ImhqlcHA0EEYSjpoPJrdsk9V+Yn1xH2HJlGdIauKdEduqax0OKQm
 LCdbvNlkKoACLHLKpaIvw8sFw5ULnFiDm93eHeJdFYiXirA3jwKhUJ7w8nWSBmzJtVEras1eZKs
 DWDXgUR2Z1IPZ5Apo7cesAq1wRPVyqY9/Mqss5aRzxlnEjeFPGsLhaKoZf++RsAvRjTtv2YYeVd
 uFIu4lNS9G1GCJITxSHLCrDtGHnY4mVNvWl9LphazgM/sKXoAXLCpUyJ/C2bZfDAfDDlR6k61CM
 xz6jChiJzNBqWRzTVa+8w3GDN8pTHxhg2DNfg/4LMxWETQ6nXdUpF+3MOUFEzhXLL5cuC5lDPcP
 pW0h3ggkx37uo9lXNIHQ3yH4PrGCb736W9NEjh3HFFd0YR4NDvAfALgbCaHR1k8uI9gTT2VFRuW
 w0J9Wmw/Y3Dr4s2h+fQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5ded17 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=JihTIjyhq8c3zjJnFREA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5r8UI_KIsPLgVlf6duzEvpKbJuNWuNpC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMiBTYWx0ZWRfX3YnfaCAgKgYY
 r6NRhUftVmwlppBGWtsK/JsogrOMhgDlXXzHqohB8mH7Gp2tlzg6t8vc+KRPCrDcLGNMd4S2rCo
 T9kokJeZy77YiSRJXNe9KYIj00UYSd4=
X-Proofpoint-GUID: 5r8UI_KIsPLgVlf6duzEvpKbJuNWuNpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200102

On Mon, Jul 20, 2026 at 11:03:01AM +0200, Christian Borntraeger wrote:
> Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> > v4:
> > - Add two more cleanup patches based on Sashiko feedback, however I
> >    don't consider them as bug fixes. This is more cosmetics:
> >    - Use handle_fault_error() in do_secure_storage_access()
> >    - Use goto statement in do_secure_storage_access()
> Shall we run the kmemleak fix (for the initial memblock) and maybe additional
> kmemleak changes for the other secure memory arady  on top of your patch set
> or shall I run them independently?

Please handle that independently of this series.

After reading through all the Sashiko reports, at least (Sashiko) AI review is
now complete. All current findings are either false positives, describe
intended behavior, or are addressed with later patches in this series.

Now waiting for human review :)
