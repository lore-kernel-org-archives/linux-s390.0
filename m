Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43E130A79
	for <linux-s390@vger.kernel.org>; Mon, 24 Jun 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223197; cv=none; b=aRBlInCcEVpl9wTXNbEKXtP3fBXCVX4F+OcbXECMICDJXdAaKB7G7rBe4LgCRO2j0ocrEBFkNISoidHGqxXG1r850t3ncvnlcQkFYKlaGP2OPnVFx5BeJRXZqeYDa8E/qshFFHaCNEHJ2q2XzHB6lB8R407TqpbzVBhNMf7BB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223197; c=relaxed/simple;
	bh=GIYTrL/aSx3Oc2Xjok7A34Zp3U23ftjCT2IaewhidA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+UyylRkVrhN0VoKjpajthA6QFgXYIsX59AvlEBfFusKgra21vH3kB2QNtYaWplPi6dhFdQC73P9GMb7tZ7Ii9ilYZty9XRh/+GeRkZTlvakE2Nus1H9uNrZYF/N/q13cZwaC5QNbTx+/g/ZAZnxxltv8jCooQKJdM56+GouCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QRJlTgAt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QRJlTgAt"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O9x4Ba004693;
	Mon, 24 Jun 2024 09:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=89522qxhsfSinIEqBMQZ7b2jkBe
	+t6clx6IJSwj6+h4=; b=QRJlTgAtRiPos3TN5EnVoCxWkI4jYwaIqgrz9yllOsZ
	qeCpIqYqGioQh6tVuRIgRnaDMoyfdE1eZksngm+UlXqPqgOhLqM18yjTPAoFkYHG
	LyKanib8CWq17uiIZGNTatcspbDrK7J4A6voPl/A6eVcRXCAM2GdXC0WaPE7BWnt
	S6jGFeTrsnBgdt9XXFjBVRyy7ztVIhR+V3RrHgnrIngkDGsErXtFCoaV003/7d51
	pggzfKcgu9nCxia8FHbZvSz1MDiX1lbjmv2F+PxxvrkW1nxbAHqMIvZ7gPoJinzW
	toqHQx/LqG1mGrTqgrVL//8XxdfpeIl65zob64kw6oA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy6n4801k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:59:51 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45O9xpoF006863;
	Mon, 24 Jun 2024 09:59:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy6n4801h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:59:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45O8dj83019672;
	Mon, 24 Jun 2024 09:59:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xpqrj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:59:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45O9xit820775190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 09:59:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4AF2004B;
	Mon, 24 Jun 2024 09:59:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195FE20040;
	Mon, 24 Jun 2024 09:59:44 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.81.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Jun 2024 09:59:44 +0000 (GMT)
Date: Mon, 24 Jun 2024 11:59:42 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, jpoimboe@kernel.org,
        gor@linux.ibm.com, iii@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 0/4] s390: compile relocatable kernel with/without fPIE
Message-ID: <ZnlDjmakBRntXQei@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20240219132734.22881-1-sumanthk@linux.ibm.com>
 <ZnHv/HmiYHoQRkUU@redhat.com>
 <ZnMO4DOBZ2qz4Twg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <4610b08d-46a4-b6fc-2ec5-a88abba7022c@redhat.com>
 <157b32d5-7e68-a77f-6f72-356433e4a942@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157b32d5-7e68-a77f-6f72-356433e4a942@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r5bZMKkEDl0xDnnHp2PwNxPHvTPkYsXt
X-Proofpoint-ORIG-GUID: 0GZ3trceZQYY8JhNwmVT3jXxSnP9hf9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=847 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240079

On Fri, Jun 21, 2024 at 12:59:21PM -0400, Joe Lawrence wrote:
> On 6/19/24 14:23, Joe Lawrence wrote:
> > On 6/19/24 13:01, Sumanth Korikkar wrote:
> >> Other Note:
> >> The latest kernel is built with -fPIC and linked with -no-pie (reference
> >> commit: ca888b17da9b ("s390: Compile kernel with -fPIC and link with
> >> -no-pie")) which also avoids generation of dynamic symbols and helps
> >> kpatch usecases (when num of sections >=64k sections).  Also the build
> >> options would be similar (-fPIC in kernel and -fPIC in kpatch-build)
> >>
> >> For latest kernel, there is no need to add explicit -fPIC again
> >> in kpatch tool.
> >>
> >> But for the intermediate commits, yes, makes sense to add
> >> it in kpatch-build tools and will create one PR.
> >>
> > 
> > Interesting!  With 00cda11d3b2e ("s390: Compile kernel with -fPIC and
> > link with -no-pie") it sounds like the original vmlinux would be built
> > with -fPIC as well, so the optimization decisions re: __mmput() would
> > likely be the same.  I can retry the tests with v6.10-rcX to verify.
> > 
> 
> To follow up, all of the kpatch-build integration tests work with
> v6.10.0-rc4 :) as the kernel is built with -fPIC and so are the kpatch
> reference and patched builds.  For pre-v6.10 kernels, I think there may
> be some instances where a patch author may need to account for slight
> build differences to appease kpatch-build expectations as I noticed here.
> 
> -- 
> Joe
>
Hi Joe,

I tried bisecting provided rhel config with defconfig, but didnt
succeed yet.

However, I tried using KCFLAGS="-fPIE -mno-pic-data-is-text-relative"
instead of KCFLAGS="-fPIC -mno-pic-data-is-text-relative" and it
generated similar output.

* objdump -Dr -j.text --disassemble=mmput kernel/fork.o

Disassembly of section .text:

00000000000011d0 <mmput>:
    11d0:       c0 04 00 00 00 00       jgnop   11d0 <mmput>
    11d6:       a7 18 ff ff             lhi     %r1,-1
    11da:       eb 01 21 3c 00 f8       laa     %r0,%r1,316(%r2)
    11e0:       07 e0                   bnor    %r0
    11e2:       ec 08 00 06 01 7e       cije    %r0,1,11ee <mmput+0x1e>
    11e8:       c0 f4 00 00 00 00       jg      11e8 <mmput+0x18>
                        11ea: R_390_PC32DBL     __s390_indirect_jump_r14+0x2
    11ee:       c0 f4 00 00 00 00       jg      11ee <mmput+0x1e>
                        11f0: R_390_PLT32DBL    __mmput+0x2

* KCFLAGS="-fPIE -mno-pic-data-is-text-relative -fno-section-anchors" \ 
  make -s -j$(nproc) kernel/fork.o ; 
  objdump -Dr -j.text --disassemble=mmput kernel/fork.o

kernel/fork.o:     file format elf64-s390


Disassembly of section .text:

0000000000001230 <mmput>:
    1230:       c0 04 00 00 00 00       jgnop   1230 <mmput>
    1236:       a7 18 ff ff             lhi     %r1,-1
    123a:       eb 01 21 3c 00 f8       laa     %r0,%r1,316(%r2)
    1240:       07 e0                   bnor    %r0
    1242:       ec 08 00 06 01 7e       cije    %r0,1,124e <mmput+0x1e>
    1248:       c0 f4 00 00 00 00       jg      1248 <mmput+0x18>
                        124a: R_390_PC32DBL     __s390_indirect_jump_r14+0x2
    124e:       c0 f4 00 00 00 00       jg      124e <mmput+0x1e>
                        1250: R_390_PLT32DBL    __mmput+0x2

* For commit 778666df60f0 ("s390: compile relocatable kernel without -fPIE"),
  "-fPIE -mno-pic-data-is-text-relative" could be used to prevent
  confusion to the kpatch tool. I will make changes in the kpatch pull request.
* For latest kernel, both vmlinux and kpatch-build uses -fPIC and
  hence no changes are necessary in kpatch tool.

Thank you,
Sumanth
