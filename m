Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C92836E;
	Sat, 23 May 2026 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552109; cv=none; b=nrbtQMTDIoP6fMusDHQ2XLAuOFnoqNDBEqUpA0sHgDfbnbphbt1l5752iUeg2+nPI1Ui1+YksdM/jIKK44mEIbJs4TUS770IZ0tOPm5AHie257PdC8n/hRrcEKOmnbE0nVocn6WCTt7wcHnROeYWAf46vMH+gwJ9VHRgn4vD3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552109; c=relaxed/simple;
	bh=XwbkizAxSc1xetG99W6lpFJYs6Mr22GQ4NIABCBMKPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S236tnTdHI2hDipkwHjDCXDbH5qhUTQVegaj//9cQD+tWs+ofvfnLWfOkqThsyzY2u1JhqK63+Y7NaVwxBiMhZ/vqhJNwFLTuf/HWHVDSao9w6zwXIXlrCdI1QuSXMtmrui0hwaJUHx5HRU5PdzqUZs5+cZOVLoZ2GXvDHVAN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sy4cyYHW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sy4cyYHW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NF0AJs3868460;
	Sat, 23 May 2026 16:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IVpphrpDBqRHmWFq25OiiECXVjJJBR
	rbPzqwydk+648=; b=Sy4cyYHWIOeyBKDg4UQRm3ufkPhO/cvBqANa2gePOhmmLq
	dA/K5fSCgIzOfPGBTdVhljyWzco6kHddxNdIuGVzFqxy6/d/RXunvT3sZBsbdnt0
	it0EEEelYZHsBKyzWFBT9w9IldqzB553EZ89ljnGIuZToCG9ZVy5JtvBJCkiQWw3
	ENIDiGgtbYZ1GfSvNpcSpvWe4Qq+UI1mb948HBC+2qSm4sws4tBhBt+KgqSGSut+
	CaQEFQ4Uj9dkn+MPsL/x3jQSa7FUIBaQ6rBfZk8gc2/mJEEk3BWdRNmKLdsOw7IK
	obxifDkqkFMT1PaTwp4vWG9fRmxDqg5CNcOK36cA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nbsakr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 16:01:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NFd8In012837;
	Sat, 23 May 2026 16:01:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb480hppm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 16:01:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NG1X2751577164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 16:01:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 403B82004D;
	Sat, 23 May 2026 16:01:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6B5F20043;
	Sat, 23 May 2026 16:01:32 +0000 (GMT)
Received: from osiris (unknown [9.111.89.208])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 23 May 2026 16:01:32 +0000 (GMT)
Date: Sat, 23 May 2026 18:01:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        linux-s390@vger.kernel.org, mripard@kernel.org,
        sumit.semwal@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260523160131.11676Ac3-hca@linux.ibm.com>
References: <20260522230606.883180-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522230606.883180-1-tjmercier@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a11cf62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=FOGFa6JwZNi86Dr7BrUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Y_wJIeq9mi3OSd7znAB8gEPADIUzjUSu
X-Proofpoint-GUID: GCoDYhQF4hJRpt1ODb04frUCm76PF4fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2MCBTYWx0ZWRfX+kZ3JVNV0AOd
 CpJkq3gBoTyTU4d5Swhpbl2ldkWSfwUShMWirN4p28MRt5oRxYxbfKoBsvoGoIOYWKZzI7a0fyx
 4jmJZ0wIe7UtZK++/d9GvSqadLVD2+Qw74LvUbhDhHB+X7nMCqch2vmNt+RZ2K3jNq5zBJxZAVg
 3Rc0zpa38r/S/WQbZGjmaEDKFnEx1l15JM2R2xSqhy2iEk/e5a0Y+mc7SPmlKs6C6vGHAZ8bKfy
 ffsbnCBw9qKtGyFgPEuIS/odbPRT7VAi/uNnCq8zA4YGDZMtyT2ngWIDpjObNFeTmb4sHcRQmQ6
 zdS0Q98JaLEpOf+FDwoMXHM0PGp+d3mPt29wawrmPieccjAa5/IGKxZsqNR6f9lkjZZylHieXnU
 Tu4QPohoSPPdRyacFmhjwZo6zppR6HYGwAxJCtkZCXvIhnxAvBb+87AZgSxiIrvvDDAa5WmD7TN
 755iFZglvRqRIQFbADg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230160

On Fri, May 22, 2026 at 04:06:05PM -0700, T.J. Mercier wrote:
> After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> module") the system dma-buf heaps can be built as a module. The
> system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> but those functions are not exported on s390. This results in a build
> error like:
> 
> >> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> >> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
> 
> Export the functions so system_heap.ko can be built.
> 
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  arch/s390/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)

Fine with me, but this should go via drm-misc-next, since the commit
which breaks this is currently only available in linux-next.

Sumit, I guess you will add this to your queue?

In any case:

Acked-by: Heiko Carstens <hca@linux.ibm.com>
