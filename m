Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423721A443;
	Tue, 29 Apr 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938346; cv=none; b=HZQWaBzL/LDlKM9sI3gUx+NpxhQO8lLJ48FMGIZRq42NFzlD6RNKFAONfzeQZn7IUY493NtzkGBhIqEib08gdyqbMyR8yCZHmj8SGQaGEs2j40HuX95MvvHdR07i2pUq5NqDRzzSlyb/TlOzX7IOvUzeuQO9vH+79IjAN3syCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938346; c=relaxed/simple;
	bh=boO/GhDvwrGxI/EyyHhHi+l9iqRNhSy8IeYhe8K3POQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgmmB3WUtm5lOYCNyxP6Ajqgc8Be976ZFGPgLe5RS8aVd8iLVO5lQhFhTvSHcuHtwt+N/nWJ9LK5ucJH3fxFiQc2g8sN0IIlkoeUdlp8jKft9Vc+wpgrW2ogB/itXaqe01DC2JdaXxsNALwGs1JIqqigkHsbVCh+yHORMYi7U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M8GZ2FPf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M8GZ2FPf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4ENbG028123;
	Tue, 29 Apr 2025 14:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dNyeQB
	obZcGmWUmeuxNsNV0sU1HqmfJw4D6Zghqc2QA=; b=M8GZ2FPfCgF6URMn+e0wRl
	Vnp4MhQWo+QK6bpxtw0aSMhpyMWa0LTtqQIPOVAQ9LH/3i8np47niWQiYG7OWE6v
	S05gHnGhHBtD1rtQ9iSoVVGCjF0C1pbFh3cK1j9du482RgA6r3poCLYIa1MiyD9j
	w1NFidkuqWmZ703N3PTgfL4qVnuCC7HE0hTzaWl2GQCihvC+BXImjAln3VkWx6vS
	Nsh7qHUzKpy7BznLMGnuU14N389JIHhZcN4oMbwjBBRX1EQVUryl0mkQfQbptKWQ
	nIxK2b3zUtxdtc8G6EQ624ntyNsZr9XjibhjCTW3DYb5rRAq/xYD+xxkPDzoS9gQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8mbuf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 14:52:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDotUM000675;
	Tue, 29 Apr 2025 14:52:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpbprs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 14:52:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TEq6Ye33358482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 14:52:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FBE20043;
	Tue, 29 Apr 2025 14:52:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9873C2004B;
	Tue, 29 Apr 2025 14:52:05 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.6.190])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 29 Apr 2025 14:52:05 +0000 (GMT)
Date: Tue, 29 Apr 2025 16:52:03 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List
 <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org
Subject: Re: drivers/s390/block/dcssblk.c:718:undefined reference to
 `kill_dax'
Message-ID: <20250429165203.48cc5baa@thinkpad-T15>
In-Reply-To: <202504291604.pvjonhWX-lkp@intel.com>
References: <202504291604.pvjonhWX-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uCX2BGG2_SgjW4kDNt2jbAbAh0vUAzV3
X-Proofpoint-GUID: uCX2BGG2_SgjW4kDNt2jbAbAh0vUAzV3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEwOSBTYWx0ZWRfX98AZux04bRMR xYURugpYfWDlGAxJavcAc7hN5HFhWkJkPA/ut2FEkBVb7L/QVrEK/64ZAtpaorz5XWQpTTTfr2o Jc/MHSKZsZfF6tCaUy2V9HeM3Opfox+AUwFxDcYWeua25nKSCvGFG0Cu0H4MeYOJyFsf0krbf6u
 fb4WCd6B4XuramAKPZ2h/5x/KW7Bas/E6atC0o8YpSXOJbu6RwTJhSHKGube6imJ+1ypFORBnc7 RReqRSnh3fGjbMP68aaFOsPQ4d/cv9Wu2GX6j1+ptRqj72tRpfimWHZcjPhxda/i+e2Vbk8eTXd Q56ywcTBKNsg5XaIEV5D9ZpRNBipwQeFDqXmQh+hQKYeTd1vyO2B1Ji8uEyNyxGtajq4JgZSnWV
 ruqr8HIS6fbkiAJqx2wloH5rqG1Rdi3eyMybx/H7nGsurXF7v8rbSVrEz+YKqOg62if8ZV4H
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=6810e799 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=Ikd4Dj_1AAAA:8
 a=Hconwz5XVgyAt6oBMeoA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290109

On Tue, 29 Apr 2025 16:27:39 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   ca91b9500108d4cf083a635c2e11c884d5dd20ea
> commit: 653d7825c149932f254e0cd22153ccc945e7e545 dcssblk: mark DAX broken=
, remove FS_DAX_LIMITED support
> date:   6 weeks ago
> config: s390-randconfig-r132-20250428 (https://download.01.org/0day-ci/ar=
chive/20250429/202504291604.pvjonhWX-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f=
819f46284f2a79790038e1f6649172789734ae8)
> reproduce: (https://download.01.org/0day-ci/archive/20250429/202504291604=
.pvjonhWX-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504291604.pvjonhWX-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    s390x-linux-ld: drivers/s390/block/dcssblk.o: in function `dcssblk_add=
_store':
> >> drivers/s390/block/dcssblk.c:718:(.text+0x1b98): undefined reference t=
o `kill_dax'
> >> s390x-linux-ld: drivers/s390/block/dcssblk.c:719:(.text+0x1bb6): undef=
ined reference to `put_dax' =20
>    s390x-linux-ld: drivers/s390/block/dcssblk.o: in function `dcssblk_sha=
red_store':
>    drivers/s390/block/dcssblk.c:417:(.text+0x2c2a): undefined reference t=
o `kill_dax'
>    s390x-linux-ld: drivers/s390/block/dcssblk.c:418:(.text+0x2c48): undef=
ined reference to `put_dax'
>    s390x-linux-ld: drivers/s390/block/dcssblk.o: in function `dcssblk_rem=
ove_store':
>    drivers/s390/block/dcssblk.c:803:(.text+0x42e2): undefined reference t=
o `kill_dax'
>    s390x-linux-ld: drivers/s390/block/dcssblk.c:804:(.text+0x4300): undef=
ined reference to `put_dax'

This is because it's now possible to have CONFIG_DCSSBLK=3Dy, but CONFIG_DA=
X=3Dm
with randconfig, since commit 653d7825c149 ("dcssblk: mark DAX broken,
remove FS_DAX_LIMITED support") moved the "select DAX" from config DCSSBLK
to the new config DCSSBLK_DAX.

To fix this, I think the "select DAX" can be moved back to config DCSSBLK.
It is still ensured that the dcssblk driver does not actually use DAX,
because of the check for CONFIG_DCSSBLK_DAX in dcssblk_setup_dax(). The
remaining calls to kill_dax() etc. will just pass NULL as dax_dev, and are
ignored.

Will fix this via s390 tree.

BTW, Dan, your commit said "remove FS_DAX_LIMITED support", but it does
not really remove all the special handling in common code, only makes
sure that dcssblk (the only user of it) does not use it anymore.

I'm pretty sure that there initially also was a version that did remove
all the now useless FS_DAX_LIMITED handling in common code. Did you leave
that out on purpose, maybe defer until after Alistairs "Remove pXX_devmap
page table bit and pfn_t type" series?
(https://lore.kernel.org/lkml/cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfa=
c.1739941374.git-series.apopple@nvidia.com/)

=46rom s390/dcssblk perspective, FS_DAX_LIMITED can finally be removed.
We will either switch to proper ZONE_DEVICE if Alistairs series makes it,
and ZONE_DEVICE won't need the extra pagetable bit, or completely remove
DAX support for dcssblk eventually.
