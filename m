Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA3423A9A;
	Fri, 25 Sep 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338978; cv=none; b=CgIbdxSq/E0S9Le+wk5LeLwmqXV/909Ror889JQYq2be5xh2HvEmHHK1rUdSlYS+pQPZgGRWH8v/7qYCV501vY/PzG6kQbFVB59/qgVaneoGgTul/bkEJDkmQC3qf94XVOwHjHcbrbqjfsK7pF1/B6D4iBl7ddb/4Auu8tLW72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338978; c=relaxed/simple;
	bh=0ACv1809DfGA4vELTXrXfs3/zxOTzKCq8MMYFsUNYWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T97vrhZhahgLfdr2mYVlUHf32v09G3+i9ssKJQid5YPCBmhyd4R54k4ix9vo1L5HJooqNOw/D0BAdGHHDyl8lHgrYYgyi3MwDNfPsMYVvcjF2x/HkXEJ2Str2AU/ZR9bxXmQRl6rUQAtcYX8rPvS34dBiiJ5WI2X/42UQON9i90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FGkW6JfC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FGkW6JfC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aYBQ102909;
	Fri, 25 Sep 2026 12:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mvw6gS
	TyUl9utE3cKpF7iTq0plMZ5MKZAGZ6qetjor8=; b=FGkW6JfC/tVE7/62s6PVA+
	isV52cAlHEAD+gSoShJjRE5G5PLZusg587FzdQ7nyD9QVeYtvhaUfuZ/a2LeIeea
	G8h/I9bnZTNG9qekLCIV1YEUo2bEQ+7E5I0Mf2MCJ44g/XFpNIsMd3Q5C8Eyvc45
	VCKj/hFlye0SHJLFzr9yvs/+45f/IXXFj3jXZfTbqvPxFdSEFPsx4kzzW9X+BiAE
	WLY2dv7VyfiE7IxXhXB+HmqgJtU3C9KMM/H0ZdGVe2Lc3fGnVg+I/BLhYpNnH2TA
	EjzifgfcmUnM3iyuzfx12AYV5ffR92WhjlTwF5kThbtrf3gR8jWfrCEOwTvqjT7w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvp04j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:22:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9qXYF3288196;
	Fri, 25 Sep 2026 12:22:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe22ca6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:22:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCMp0i25559590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:22:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FD442004E;
	Fri, 25 Sep 2026 12:22:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E32520043;
	Fri, 25 Sep 2026 12:22:51 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:22:51 +0000 (GMT)
Message-ID: <b49ec974-6937-4057-869b-a6e2d5958c6d@linux.ibm.com>
Date: Fri, 25 Sep 2026 14:22:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM/vfio: Use file-based reference counting for
 KVM
To: sashiko-reviews@lists.linux.dev, Steffen Eiden <seiden@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-4-4a294307797b@linux.ibm.com>
 <20260924091457.74D2E1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260924091457.74D2E1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v6CI2DXbN2DTkKxRDukDW-73WzATwmuG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0OCBTYWx0ZWRfX/cPK/XxZ8NFd
 w2BFYgjHlrGaoOic0TqZAhSLWWlqzfTGnqQXjidogvuYjINI3h0xWWJX4kP3n5PlGIypkWjsIWW
 EWMVTUXMdQZSV8HJtXwclzHsdQvoFDw=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab6679f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=duDvbuwstWZkoHifAHAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: v6CI2DXbN2DTkKxRDukDW-73WzATwmuG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0OCBTYWx0ZWRfX2FTNzrbq4yFq
 do4ScruzEqU7vBawvmYvtma++XpzuuuH61tB1Q0BnLeO7ev8t9QWXtHtNt5f02amc3zQfv8EILk
 1VRtnbKHWIFbga2+ojQNBiUH0dfvwujxqbPadj+Bbjartx27+b6RdlDxPVfRENiVXSUcOEF69qo
 n650fS4mbDSKBuv93FtZyd8K3zJVaySJmwQQChpgNgwF8P7PI+hjl2rQEMM9cCMrxpixTBAZiEx
 ALVlkzz9sVQET1nE5fxCxBkYimCYeiwrzQFZKjHyZKabJuxtFmubbpiIXs1UHTdNHCTUKt0XAVC
 LQU09g/eptIVAzVv+iXZ9HuUNU6XyOpan+EVKtqRDADJWug9Rrj4rWkhFX1xmL5U9XhGWXvOdRj
 Ppt5Ehdygfk5wylpGUni6PhHJFAF3rgyAhKWSoWBZ5hU/RUxHSjE55wxQZIdtglnup9d7VSYQvC
 hcAD5XqBn2C0xbCVvBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250048

Am 24.09.26 um 11:14 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm/vfio: memory leak due to circular file reference

So with the help of AI drawing things I think this is a false positive, see below.


References between KVM and VFIO after
"KVM/vfio: Use file-based reference counting for KVM" v3

   ====>  ||  \/  /\   holds a reference (get_file(), kvm_get_kvm(), fd)
   ---->  :   v        plain pointer, holds no reference

                process fd table (exit_files() drops every fd)
         ||               ||                 ||               ||
         \/               \/                 \/               \/
  +--------------+  +--------------+  +---------------+  +-----------+
  | kvm-vfio     |  | VFIO group   |  | VFIO device   |  | VM file   |
  | device file  |  | or cdev file |  | file (opened) |  | "kvm-vm"  |
  +--------------+  +--------------+  +---------------+  +-----------+
    ||   ||            /\     ||              ||            /\   ||
    ||   || kvf->file  ||     || group->kvm   || device->kvm||   || private_data
    ||   ++============++     || df->kvm      ++============++   || users_count
    ||                        || (NEW)                      ||   ||
    || dev->kvm               ++============================++   ||
    || users_count                                               \/
    ||                                                   +-------------+
    ++==================================================>| struct kvm  |
                                                         +-------------+
                                                           :         :
                                              kvm->devices :         : kvm->file
                                                (no ref)   :         : (no ref)
                                              to kvm-vfio  v         v to the
                                                device                 VM file


Every ====> arrow points to the right or down.  Nothing leaves the
VM file or struct kvm with a ====> back to a VFIO file or to the
kvm-vfio device file; the two arrows that do point back are plain
pointers.  The kvm-vfio device file is held only by the fd table,
so it is always released first, and its .release takes the
kvf->file and group->kvm/df->kvm arrows away:






[...]

> > -void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
> > +void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
> >  {
> > +   struct file *old;
> > +
> > +   if (kvm)
> > +           get_file(kvm);
> > +
> >     spin_lock(&group->kvm_ref_lock);
> > +   old = group->kvm;
> >     group->kvm = kvm;
> >     spin_unlock(&group->kvm_ref_lock);
>
> [Severity: High]
> Does this create a circular file reference? VFIO takes a reference on the KVM VM
> file here in vfio_group_set_kvm(), while KVM also takes a reference on the
> VFIO file.

And this (also for the other aspects) might be the relevant part.
The VM file does not hold the reference on the VFIO file.  The
reference is held by the kvm-vfio device (kvf->file in struct kvm_vfio),
and that device is owned by its own fd, not by the VM file or by
struct kvm.
