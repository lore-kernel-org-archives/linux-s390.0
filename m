Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37B194C72;
	Thu, 27 Jun 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496280; cv=none; b=t2SCKFpDOaJjF74iKZc0c2SX7LjiDxGef1s/v3ZoancgJfIoZk+bAQxHjX0ET9t+fjxvXLBItKFC57h1HYq2TixD142/JeihoK8pUF/Jggdn7dqGgiz0l99qh6PY051UthDIRGn2MIpxWeaIuTkBHvkrcefYn2j+ulJ4WjK4oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496280; c=relaxed/simple;
	bh=hknuyisLYJ4y23RNqLLfEQAnG18k+vp7THFmxqwkFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N+i1bbf3n6hJhjW3v8/ywDWlCR6sviOQGm+/C4Vml4eFxr3OmRP9aJbxvqCuK3JVs3N3XK/3Y87SdqQd/9VI7vh7XfXIvtfYts3LIRQvpoRVVLi6Le0OxqPMqy8Xro8bP0IAxYz9VtVgtnPtbhApT2Dw1v8XfbdpC9thJoXeiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bOHQPqaQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bOHQPqaQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RDQvOt001734;
	Thu, 27 Jun 2024 13:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=4bX5NUKIKpBj2dDSMUxA+MFxihY
	wXOMeW5Gnxmp128k=; b=bOHQPqaQDyWQJiCswm6mehZuDF+aEnFQQusKrDjs+5V
	Q6/sa8ne58g8O/Bk+Y23PVvnY72Niy18bky0MUdmlECaU4H7pxZzpY7Ql4TvMnHn
	1FBVnTPTbYzG2FNVQzZ9oxsHWMDjegOBxR+u0fkcoJIbmfFsuzdW8eV+RSWjXDAM
	wx6WNhA+hD+IlufurBIDTnzymlEu66Xo0T1IXGZTqvaC61U5Ss9BTn4gJTlBHHpd
	pzLii6SDGVm3t0K4FKT8q+px0mAIIJTZItdcuzcL7B4Y3oa9B05zrbdv9V0LNfwq
	FbP456Q/VtYFJzlLHLT6JwvraotVOC1lIPIP1zHbGXg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4012dcs5ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:51:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45RCtLJm020024;
	Thu, 27 Jun 2024 13:51:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5mtqfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:51:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RDpBUx56558066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 13:51:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AEC52004E;
	Thu, 27 Jun 2024 13:51:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 490BA2004D;
	Thu, 27 Jun 2024 13:51:11 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Jun 2024 13:51:11 +0000 (GMT)
Date: Thu, 27 Jun 2024 15:51:09 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jnpZuO2ZaYWHUlmao-nCzNvtscbpgtoH
X-Proofpoint-GUID: jnpZuO2ZaYWHUlmao-nCzNvtscbpgtoH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_08,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270101

On Thu, Jun 20, 2024 at 04:34:15PM -0700, Omar Sandoval wrote:

Hi Omar,

> Hi, Alexander and Sven,
> 
> I just got around to testing drgn on s390x on 6.10-rc4, and it appears
> to be broken. I bisected it to commit 56b1069c40c7 ("s390/boot: Rework
> deployment of the kernel image") and narrowed it down to an issue with
> the KERNELOFFSET value reported in vmcoreinfo.
> 
> On my test kernel, the ELF symbol for init_task is 0xc96f00:
> 
>   $ eu-readelf -s build/vmtest/s390x/kernel-6.10.0-rc4-vmtest30.1default/build/vmlinux | grep ' init_task$'
>   72273: 0000000000c96f00   4352 OBJECT  GLOBAL DEFAULT       18 init_task
> 
> And the address in the loaded kernel is 0x3ffffeaaf00:
> 
>   # grep ' init_task$' /proc/kallsyms
>   000003ffffeaaf00 D init_task
> 
> 0x3ffffeaaf00 - 0xc96f00 is 0x3ffff214000
> 
> However, this doesn't match the value of KERNELOFFSET in vmcoreinfo:
> 
>   # eu-readelf -n /proc/kcore | grep KERNELOFFSET
>     KERNELOFFSET=3ffff314000
> 
> It's off by 0x100000. This causes drgn to compute the wrong addresses
> for all global variables.
> 
> For context, I'm testing using QEMU emulation on an x86-64 host. Note
> that it logs "KASLR disabled: CPU has no PRNG" early during boot. My
> exact setup is:
> 
>   $ git clone https://github.com/osandov/drgn.git
>   $ cd drgn
>   $ python3 -m vmtest.rootfsbuild -a s390x --build-drgn
>   $ python3 -m vmtest.vm -k 's390x:6.10.*' bash -i
>   # python3 -m drgn
>   >>> prog['init_task'].comm
>   (char [16])""
> 
> That should be printing "swapper/0".
> 
> Any ideas what's going on here?

On s390 no kernel symbol exists below 0x100000 offset within the
vmlinux image and thus this part is never mapped into the kernel
memory. That way KERNELOFFSET turns out to be off on value of
0x100000 - and that is what you observe.

That breaks the way drgn finds a kernel symbol, but does not
exactly contradicts to the existing KERNELOFFSET description
(Documentation/admin-guide/kdump/vmcoreinfo.rst):

===
KERNELOFFSET
------------

The kernel randomization offset. Used to compute the page offset. If
KASLR is disabled, this value is zero.
===

I would say to some degree there is also inconsisten with regard
to /proc/ files existence:
/proc/kcore    is enabled by CONFIG_PROC_KCORE option, while
/proc/kallsyms is enabled by CONFIG_KALLSYMS option.
I assume drgn expects both files exist and does not work otherwise.

Nevertheless, it is still possible to refer to only one file for
symbol resolution and use an always-present symbol. E.g _stext
could be leveraged like this:

# grep -w init_task /proc/kallsyms
000003ffe13e9400 D init_task
# grep -w _stext /proc/kallsyms
000003ffe0000000 T _stext

0x3ffe13e9400 - 0x3ffe0000000 == 0x13e9400

# eu-readelf -s vmlinux | grep -w _stext
178112: 0000000000100000      0 NOTYPE  GLOBAL DEFAULT        1 _stext

0x13e9400 + 0x100000 == 0x14e9400

# eu-readelf -s vmlinux | grep -w init_task
  498: 0000000000000000      0 FILE    LOCAL  DEFAULT      ABS init_task.c
182344: 00000000014e9400   8960 OBJECT  GLOBAL DEFAULT       28 init_task

I guess, the above holds true for all architectures.
If so, I would suggest consider using that approach.

Having said that, we will try to turn KERNELOFFSET from a synthetic
value "Used to compute the page offset" to what drgn expects it to be.

> Thanks!
> Omar

Thanks!
