Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67E2D5408;
	Wed, 14 Oct 2026 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979556; cv=none; b=AAf9PIF9w44IhpHPxtmJN9bHdAom6LgO12NpE7uWZ0Vyh4IL5xf6MuaDstUaDcGHy9KVPM3lDJOwRGm2sSxcklsDu3J22SBAwID/j58vUSnwTxLtgEV/0zOYsHTAZ+sufW/x7EhKzqC/s+Mclr869sPQYMXb0rfG2R/y1zPtONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979556; c=relaxed/simple;
	bh=xqu6L+MLcBsLQpL3iAU8RGfBpTwHd2oCTda797P9Cfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAMorMSDY5nIL3xVZkONfgzNViV6pX9gyAQk8oeGx19kJBZJx/kGubnes8OD3hkDs61NzfVfvUVIYpk9N4qMlCc8K4yoYw/kdX+5XoKLrVJ6xn3IjjBiukptOuFM4+bw4fvD4CcygFoebwcC/OvvIvfn9zR6t9DnNCsoVZSIl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYQ2N0nS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYQ2N0nS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9waOp2016607;
	Wed, 14 Oct 2026 12:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ajZHd+qh6V9vTCXwQWUfdpmTLNkyLK
	ozm1g9bOoFoFc=; b=JYQ2N0nSXD/tQ/r+o3naoBOH1U+r2oPu+xjGpN+7txoDex
	Z0IWl63DxMAVur3sx+kmGREDCBqZc6k1HCDRjrOoEK+taOKH1OloSc9taF9O0FWY
	WpVjMbVUV3y+904j6Wquin+qDgUZtE0vakTE5A47rqq/xC7whZpk/bAH05j6NUMo
	GyNvztnXQB+E5AUtc1L0KRpmZ7LHjGzNNOr8tWNd56WpJVQz0J/T0JweCGvwVkOM
	38Ai7Y5IXwL6To2w1AEdek15AbDAMLoAedQcEW17k9uz90AlYajIG2XNMhTS+zOV
	bWm4qcBhLuQq6bVn5TQRsfV9c0VsPZQvM+kgHPMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugm5g8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:04:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAnqN23211855;
	Wed, 14 Oct 2026 12:04:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ymp38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:04:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EC4l5Q50397474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 12:04:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 287A32004B;
	Wed, 14 Oct 2026 12:04:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC8420040;
	Wed, 14 Oct 2026 12:04:45 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.111.94.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Oct 2026 12:04:45 +0000 (GMT)
Date: Wed, 14 Oct 2026 14:04:44 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Teigland <teigland@redhat.com>,
        Alexander Aring <aahringo@redhat.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        driver-core@lists.linux.dev, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
        linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] s390/sclp_mem: Allocate struct sclp_mem
 dynamically and add kobject release
Message-ID: <as9v3PUb0TymCvsc@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013223946.1836757-9-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acf6fe5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=1KnzZOXWGbpzuJ82zDMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _EktMNlxNi0Zhojhx4ASfWVXd_b7DOlL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NiBTYWx0ZWRfX0fUPhxARNcJa
 9nS/iCLcc7dEQrcybdImltBqHci5KonN9BgYs2DYbqx1d8S2XOqe29HUtCRqWBLErMceEtiShcs
 4sOis3II/pHWvCugYS8aQjzU25z5oQrs/O3mU6gDGKNdZjvK+pDPTKbfQLhBgdreLHYt/eXKSLj
 8iaqk3GpEmiCS1rkaREHPfI9BfxMESceMf6fSb58kgdsHk98lVK94W4Z13ZaUDqucgF8UHsrXAF
 s2Mz0WmLaipai7UjCU1P9wfoh1rJSRoR35Qnnl4GViW47ZEhEXi38+rmYIbdZGaRW5Gb4NFboLC
 VDaNe6VnoQav6/qOqN3N/a+a+5cDALYf91XsQVsXP8nIWP35y0wihJcXC0kc0O7eYfGysmumoj8
 nH3TGHAss/iHicos4JusXZh5QK06OZzsWCTSFTnMelfNV7UtEZDijv++v8M3SGrsGa+NyH77MdL
 5RJO9I7QJmKjVLI0vig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NiBTYWx0ZWRfXzh8XCAetvSto
 U4lKpTbi/IJ/4y5zYP4Ex816LutfdS+PI20y7l1acTJ0MKa2avnNDCgOzXRPOLPzbCG+UhRciiw
 hNFMfBzpg0MTAxSwj76JilCNvE6uZfI=
X-Proofpoint-ORIG-GUID: IbMwSeABL9gn-KtBlV7Mt5gD5Rq_VQT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140046

On Tue, Oct 13, 2026 at 03:39:43PM -0700, Ian Rogers wrote:
> sclp_init_mem() allocated a single array of struct sclp_mem with
> kzalloc_objs() and registered each embedded kobject using a kobj_type
> without a .release callback. Allocate each struct sclp_mem individually
> with kzalloc_obj() instead and add sclp_mem_release() to free it.
> 
> Fixes: ff18dcb19aab ("s390/sclp: Add support for dynamic (de)configuration of memory")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi Ian,

The entries under /sys/firmware/memory/memoryX in sclp_mem.c are
permanent. They are backed by a single array allocated at boot and
remain for the lifetime of the system.

Memory hotplug can add or remove memory blocks under
/sys/devices/system/memory/, but it does not remove these firmware
entries. The /sys/firmware/memory/memoryX kobjects are never
unregistered or freed, so I think there is no need for
kobject_put() and no execution of a .release callback.

Instead, could this follow the approach used in Patch 11 of this series?
static const struct kobj_type ktype = {
	.release = NULL, /* Permanent firmware kobjects, never freed */
	.sysfs_ops = &kobj_sysfs_ops,
};

Thank you
