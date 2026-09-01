Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533B39023C
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259363; cv=none; b=HG+prLcvr9QwHpe8mu0wKKdKV32GLG0AirvpGgz1JMpOjsbs63nIldK4bOMfv55oek4Ny1kx4SOTW9vdbfxSBpnbV1HKlcmkzJl5E74tME93e8dxGsmHFpyJo/Nt627goZW3/E4Yvgkyjj6rVRvruawz34jz9nm89FoaxO0Eph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259363; c=relaxed/simple;
	bh=5O+j9wbFBpPbABPZwMc+CxUM1+W1NQGeIUyuBPXWDGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scyc7Hhj/5nfbUdCoppUrvjPBdirVS7QuOR4VlGS5sja69l8K4scyxh0mnkv2FOAfgWAoJmpJlnhKNQ6s6d0JQSsMwNVhmzfdrTQDh6HCHX0Ty1TU3NB5T8WB4Boa9Qw1jyZO6rH363opkx3vC1ah52dS9bFfYPx6een6eXD/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J+0hYKNw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J+0hYKNw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVbCR831333
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 10:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t3OAZB4N/5e4tTzWJ4csscL4+/OPqC
	svxtt+8TC8jqg=; b=J+0hYKNwfr5FgNcIDDTAfWJMKyk1f5i9NJZ9H+1sZUYFgU
	O0djlsQbYEAsq7Se0FAxno0I4FmfhSWG1ekFznxVsHS+rktqG0TnzToL2m4Q+27e
	DcZX8ruPUGyiBqBbkqeMn2pPQhwxa6ongsLXLVMc7My8pfI17wjM2MXRMC7qqlRR
	Wl0aPUM7May2G4VhPr8c7rVcQRhTtt5P6MOGZDFZRQGXRux2VeLLjQmr9Mwu9a4Y
	8c60n1Zk38edFlLM1qYPyXWJX0fkxJJlynKep6kDoKfxMNVvWsPVg0BxAlEaGafO
	QSZ2dOQyJh2LuakPsod3Do/2/flGnC84QuzzSTTg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhq7wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 10:42:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681AfJHg032726
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 10:42:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqbc19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 10:42:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681AgaS334341224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 10:42:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81A0620043;
	Tue,  1 Sep 2026 10:42:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA5520040;
	Tue,  1 Sep 2026 10:42:36 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 10:42:36 +0000 (GMT)
Date: Tue, 1 Sep 2026 12:42:34 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Subject: Re: [PATCH] kmsan: fix false warnings in return_address on s390
Message-ID: <20260901104234.14482A96-hca@linux.ibm.com>
References: <20260831152811.3817938-2-aleksei.nikiforov@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831152811.3817938-2-aleksei.nikiforov@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EiI9YziBIQTOuelj0Vodgk4ceKJg63FV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MyBTYWx0ZWRfX+swLFc9H7UU/
 s+XDXa6z9GBoymErKM1tXBFoFilBoE+3vgzsSgioX4i0Cwg07rDdqVIHdPGN2pR2EF0YPCzBfH6
 pY2CJCGQrXck0sAO3kKlNNivZ2Tx5VWbaGhbVoyytFnIEzIhhOB22XEDhHMXmOQkHYaU34+4Qm/
 68uuaQaO/IilFkaUf6i/1JRazuyrqzQyk1C/PSqS+eetKwBZDUsGteOHZVutXE7869i1AGKkkzx
 OwT4/gUdTPsLCZLZlENI1q7IABnLLbwv7sIxWwKfVHO5vP1ezUljsQKvcrGWz7WHlKx8v7KU7hO
 e8Cd7GtAfGG0edD9qOdWAX9p/DrCIVpkvb1iABH9UTsytBT2oMd2ePnNeV+B8iFTWv41UYnqor1
 DtqAzv7+0cTzaGsldYrqBOq6Frf0sKe/3cbWk7QRLM/5tgb1NodeMOjK+DAX6aykfBQVAlBvrFf
 HN/o589JX3klc9ivosw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96ac21 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pAONFi0PjJ7zOFmF0UAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MyBTYWx0ZWRfX3ljG6ga3gaLi
 KqbDPvvHcjlVMxsBjWg9UnPRpfzEJ/JV3oAGnYIoQKbf6Wz+0mwUikhB2DvLBk4ty4KEkFqQIVX
 TrdtDs7fg7txLrpDdWA9ScWLt0DfMkU=
X-Proofpoint-ORIG-GUID: EiI9YziBIQTOuelj0Vodgk4ceKJg63FV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010093

On Mon, Aug 31, 2026 at 05:28:12PM +0200, Aleksei Nikiforov wrote:
> Function return_address manually traverses stack frames
> using backchain on s390.
> Stack frames are written to stack in function prologues
> and are not marked as written for kmsan.
> This may lead to previous mark being used.
> 
> Let's assume that there was an unitialized area on stack.
> Later backchain and other information is written there
> in function prologue.
> kmsan markings are unchanged in prologue.
> That means data is actually initialized but incorrectly marked.
> And when data is read, a false warning is emitted.
> 
> It might be possible to fix marking data written in prologue of function,
> but it may be somewhat complex, especially in leaf functions
> where no stack for next function call is allocated yet
> and new function call would be required for kmsan helper function.
> 
> Other approach is to mark return_address function as noinstr
> to skip kmsan checks there. That's approach in this patch.
> 
> When kmsan is enabled, a special noinstr wrapper function is used.
> Since one more function call is introduced,
> depth n of backtrace is incremented to account for this function call.
...
> Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> ---
>  arch/s390/include/asm/ftrace.h | 6 ++++++
>  arch/s390/kernel/stacktrace.c  | 8 ++++++++
>  2 files changed, 14 insertions(+)
...
> +
> +#ifdef CONFIG_KMSAN
> +unsigned long return_address_noinstr(unsigned int n);
> +#define ftrace_return_address(n) return_address_noinstr(n)
> +#else
>  #define ftrace_return_address(n) return_address(n)
> +#endif
...
> +#ifdef CONFIG_KMSAN
> +noinstr unsigned long return_address_noinstr(unsigned int n)
> +{
> +	/* Add 1 to account for call of uninlined function return_address_noinstr */
> +	return return_address(n+1);
> +}
> +#endif

Thinking about this again. Wouldn't READ_ONCE_NOCHECK() solve this too?
Otherwise I guess we have the same problem in the normal stack unwinder too.

Something like this:

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 692c484ec163..4a2c46341b86 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -17,11 +17,11 @@ static __always_inline unsigned long return_address(unsigned int n)
 
 	sf = (struct stack_frame *)current_frame_address();
 	do {
-		sf = (struct stack_frame *)sf->back_chain;
+		sf = (struct stack_frame *)READ_ONCE_NOCHECK(sf->back_chain);
 		if (!sf)
 			return 0;
 	} while (--n);
-	return sf->gprs[8];
+	return READ_ONCE_NOCHECK(sf->gprs[8]);
 }
 #define ftrace_return_address(n) return_address(n)

But that might also generate an additional stack frame due to an
out-of-line call. If that doesn't help we _may_ need to come up with
an inline assembly which hides the memory access. E.g. something like
this:

static __always_inline long ___read(void *ptr)
{
	long val;

	asm volatile(
		"	lg	%[val],0(%[ptr])"
		: [val] "=d" (val) : [ptr] "a" (ptr));
	return val;
}

and use ___read() instead of READ_ONCE_NOCHECK() within return_address().

Opinions?
