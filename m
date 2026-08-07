Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181A37C92A
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101336; cv=none; b=jLQ01FB/hlrHooEZLpdPEofituemdOa7JnW4tsxwGiyQMfGg7CuukGof3WhOw3A0L79r3hP3FYtnPYAqbt2I8+FQ49lMa2dpBHpDS4ttMxd12LJmnwEc2kGwoA77u/Lv9Qx+/6wxVj+VeeErlqfZlql21eyj2v/lhMuuFVz/3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101336; c=relaxed/simple;
	bh=6vTHHz6e8w59Yk7txQo0BYqld8pPncPYvriIMjL8K7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6391tY6nUcdipQ1jDqZ23KrjI1lJV1h6lF6+Ua3pZQffRAXJmuCLRoxFs5+d5KJepN9BS4Km7xiKiZA7OTZNzrADopb8+zcCMHrMa1ANuSJDbybhZLtQG6BnR4n+ZqRfcDlkEwrZ5QA1n/IdddgdDDS8kebFrVoSrDoPhj+Bg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CdDiB+sh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CdDiB+sh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IcCA4069388
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 11:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4EQUZma2KOJ+O4L4d9kyxkkUk2vkMA
	AJ9atkDELFylI=; b=CdDiB+shMimM+g0Q8slG3dUjH0APtSBMplEVdteimZp+sT
	zz2AqPCM4kNgQ77VwIiDWByp4+EHR4ZYXQawdww7kpsJZcpHsstcDedscWczHP2h
	R+GwdBvqqPBZ+YOEflxGQ/qMuomnDUUWF2zRZ+CEqvAlrniq/+4jDZeZnhBE2Slp
	TiScVituJKd3Y8A0IDMipHma6QWkwMLDVMqeOpUOBgTuV1gGYEzidBBNtt04PsWf
	+xxvqqp2mzNVbmy8nDsMZi2epgeRZ84osp3vQvLrFCwZDX4Xj42BIEBh7zr4Qi0B
	DANIPSh7TuTeF6JYeosLJslsWFFJDatgx0S7eMeg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy023f4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 11:15:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AuKJS023718
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 11:15:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyy6yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 11:15:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BFToP40173872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:15:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B42E020040;
	Fri,  7 Aug 2026 11:15:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64A4520043;
	Fri,  7 Aug 2026 11:15:29 +0000 (GMT)
Received: from osiris (unknown [9.87.138.170])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 11:15:29 +0000 (GMT)
Date: Fri, 7 Aug 2026 13:15:28 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
Message-ID: <20260807111528.17243C47-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
 <ff87bfee-148f-418f-897c-6fa9b96aff5f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff87bfee-148f-418f-897c-6fa9b96aff5f@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qMGilDSw_6jI3KUC0tHtDU4xV6iqrbXV
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75be56 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Whdyw5p1woTzbOHNaIwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: qMGilDSw_6jI3KUC0tHtDU4xV6iqrbXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX27HW7VjijOKn
 lA+i92YjZZPADmUVBkfCJZKMHIJL1XP2j0qrPB16zgWEoOk7oCj7xR2TimY0dQCcb9gcwZvWQU5
 OCqUD0WJWcnrEo5iVJoay8XorVQ/YBeczXdSptqnIFh0nXpSmduKWHTKXkqKo2Qg76yYmUOBhrx
 hiSpeQbmO0SNL63nY9u0PfqHltkTxOQDPU1kJIf1+bBwx7C0V4qGgkAEwCPn+yrpz1QBMEIwjTy
 SIrG0o8mEgEpWOBuWgKkykK/F0y4dbJxuXbNncA70efmrLf2HQjtTmSqMhoZCFHmei8sp5yXSJb
 kbQDfikyvteMj7Mb/2HwXd9THeYtPDASDauUii8MznU97EAl7oxSAKnVC8LPc/RVCW9q76e3k/9
 lBqTV3uFyxsqarIszdKjzWnP6c1ZP8O8YMD7ICfQvIKSHEPZ1KK8IuhUYyoNTn3TBBB0SpCpj9I
 d8VnBdxucZaWQNfSSHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX31gtcg/bn3e1
 kOG0VmnmhYima8BikYWdKG/MOX3YfouDQusCWtURpMURR1zWBRnfA3+tdMkyfLv1+ryu3K7KEGD
 Ui2bVI57K4DfytEfom/CPGYPsDmDTH4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070083

On Fri, Aug 07, 2026 at 12:55:28PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 06.08.26 um 17:38 schrieb Heiko Carstens:
> > Add __must_hold() attribute to vfio_ccw_sch_quiesce() in order to let
> > clang's context analysis know that sch->lock must be held on function
> > entry. This can also be easily verified when inspecting the function.
> > 
> > Without this annotation this leads to a valid warning when context
> > analysis is enabled:
> > 
> > drivers/s390/cio/vfio_ccw_drv.c:55:9: warning:
> >    expecting spinlock 'sch->lock' to be held at start of each loop [-Wthread-safety-analysis]
> >     55 |                 ret = cio_cancel_halt_clear(sch, &iretry);
> >        |                       ^
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> I assume this series should go via the s390 tree with the others?

As written in the cover-letter:

"Christian, Claudio, Janosch, I think it would make most sense if this
 goes via kvms390."

:)
