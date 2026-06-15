Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE32848A1;
	Mon, 15 Jun 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519477; cv=none; b=Qb7q+MPO2ITaah58ZDiRcULGSIDRXX0FXAlhFDCCxz6vTikEnB2UgTQCxfydpbdAh/WJDj7K1tfW/JNfzQH2e25SWLV97MW8ODa5/o/wnlQ6oBpmnbr+/wdLyOE/QCsZna1D1XhcqCSk/kU/PQz6h2T0t1ASmz+7iBcyw6s4FGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519477; c=relaxed/simple;
	bh=qpkPZrddTktA09G7g0zahjanO831RtkJTYtOiWYXRjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSiNV9HTwi8cM+L0B6qSvZhlxMcBWF+LvbpOV+c5QErIB0Fy/qc0yNs6QdQbrWg2MoIzfJ5KlPvzyP/c3C6RayucMPVCv/W/Wn3aBNL53/8/6m3kO5Xtd6dR/dv/h+3Xm1TIOsmzUDNFesCtc6V4DfJKGnQizoNv4QltWvYUb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ABd9Y7+1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ABd9Y7+1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FALnbF2170900;
	Mon, 15 Jun 2026 10:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QN3Vcg
	DDG2JDeFuKfB1LC6ism++xsGkFNC09mqe7VoQ=; b=ABd9Y7+15RqdxpjhLVMW7i
	oG6GcrJ+7yAraIsDbP6r3EYuozDnvrZ5JlNvIhMoD2sUrnIBn5BhBSe5rUkvnS//
	2xyV1YfGIrti9PIpZ6tl3UjIA5Htkvg3cUlsHIs06VSI7quYEA0DGjFeSFphvEwp
	9XqHiC46s56kc40TE0mvYl3j3j86oD+bzuu5otSdcw904I2b3KDv7SZZ54BNNqAn
	JOLHJQ0O0rvuu2D31klZJqumExN9ZLNAEvSE6ruNNbbfx0ArzxCvoRLAJXQxmMzw
	KsF5nFFepysJtIZokvfhs+xbUJ/vQ6jLq07bwDVzUhVu5yssK4U6uN3B6yv8tGCg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v27jr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 10:31:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FAJt0l017206;
	Mon, 15 Jun 2026 10:31:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjx3vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 10:31:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FAV7TD31261342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 10:31:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEA2D2004B;
	Mon, 15 Jun 2026 10:31:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B028920043;
	Mon, 15 Jun 2026 10:31:06 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.31.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 15 Jun 2026 10:31:06 +0000 (GMT)
Date: Mon, 15 Jun 2026 12:31:03 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <20260615123103.118af04a@p-imbrenda>
In-Reply-To: <20260615094300.31370D7a-hca@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
	<20260615091741.76724-2-imbrenda@linux.ibm.com>
	<20260615094300.31370D7a-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEwOCBTYWx0ZWRfX5hHOk1ZuxNGY
 nNfZ2XQHul7aCXeipCKss880xTDpAHqa3KrUr8BFOKiZ8ygZwhN+bEaitPVo9bWZpCoQOzu6xRC
 h+s49sClOHqVi9sUpezKbh1z3NuSv9I=
X-Proofpoint-GUID: kIgLwMuMqBmwAp0b3TeX_gHAroRycqoF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEwOCBTYWx0ZWRfXxh5qOsiH4UtL
 d0TKQnPjcTrjs6y8aeCTRA4p8FENnFQLqV3cEtXrY4tujxMWWg+oMzm0BZBQbOthPQ357YATrwq
 VTz14RD30NVG9rVpk/UVeoqiJp183947bSKO0h/TFD9Lm10bW6A8IIRPRvC0bpaGz+K753hjeDH
 QvT+jkn4sCK99VSByB2CK3z4c0MnGYzETWmqGZnyVImCMcMz4ujiWS+eFk/Lo9CkqpQfPrYEbYo
 sqy3BnImvMkW51lQNnk4BVos68Ut+wWB9py89yNFPhylCgpB872qYakRYv5xPteDimMGLK14ca/
 VoR1UpJVZnr8ziwx8K9iunRbnD+y5RtAS2m4+uI/JJeUParlYzMR1Ia7XZfHdptfmQs5IYR3a3V
 HIRcTkql4x44wdzCtbcHBz83vFYPWrKH36D5EmYaak1uhotWamxRS6h5SO8/oonn7tswhixJyBh
 5FXhtw2SmWIWWJl/ueA==
X-Proofpoint-ORIG-GUID: kIgLwMuMqBmwAp0b3TeX_gHAroRycqoF
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2fd470 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=4puLx-HAH6mwxuCUj30A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150108

On Mon, 15 Jun 2026 11:43:00 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

[...]

> > @@ -175,6 +179,8 @@ pte_t ptep_modify_prot_start(struct
vm_area_struct *vma, unsigned long addr,
> >  void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> >  			     pte_t *ptep, pte_t old_pte, pte_t pte)
> >  {
> > +	if (pte_present(pte))
> > +		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
> >  	set_pte(ptep, pte);  
> 
> Can't we move the logic from set_ptes() to set_pte() instead? The above

set_pte() is also used for things that are not ptes, and in those cases
we probably don't want to touch that bit, although technically it is
currently unused for present large pmds and puds.

> approach remembers me of the open-coded removal of the no-exec bit at many
> places we had, which became a maintenance mess until it was rewritten.
> 
> The compiler _might_ even be clever enough to move the removal of the bit
> outside the loop within set_ptes().

