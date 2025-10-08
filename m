Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296D4A01;
	Wed,  8 Oct 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914848; cv=none; b=P716JVfEqJwazWq0/Bx9rGP8hWTttcWX/USjOlhMk1wIcamw6cm4vzbd6yUaj/cbdRsHzbDFsId1tEootVh0ajpu30M+yUJPe654fSFOwUDz2Jc4p1sImu4g+zBILZu5w0tgLHVmqYfWzrjyZ5UudKYP6EE5k7cIBrhzzAZsf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914848; c=relaxed/simple;
	bh=RBX/JvHVp/JLTGdlufX43YS1sS3t80WXsI+7GI4P8Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0Ho+uevH66M/xSUyBnQfhXzNRPT3bZqKMwccENu27H4UzSP/RVVYAJavNbeEwv4289x5Qe4h8cA4oy7kqdHdCQ2vO0bKHhDMkBU2ZfonZ0vCa5Aw1pZjoBXJB/Ghxgp4Lps6Cq7Ghdvfx1uC27nGtnVIxa/U7lr8D+sjOuQjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/kN9LKS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/kN9LKS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5982Vevp030070;
	Wed, 8 Oct 2025 09:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QPruGH
	7fTf9jQZZnyfNgBfKH7Ef9ATtAqGNYbKyXYM0=; b=i/kN9LKSsmIECxE9pgj0Pk
	paFXt2sDl4b+d2sBH4uGOUVcKUec+xGrhyQbK0wIWCgmXsPveGyps1GWXHw+pKWz
	N4kN7G/tmKla269vrIm6mK4PdE0X8vVgQRisckMiL1u1we1omRiivBcvpw+LN5rs
	r4b/C5UjUUH9Yl+4u0MxMc/3Qw0ounpPdieaOZv+9mY/o2U9dQ9DwulkoXjjSQ6H
	s3NaLEKbh5+8j2yN0/KY3S/e6qqqseyXcmbQZbc4wjxyiHo/Vq/9DaQQTGLeDZ0z
	+LbfOTKEqpWHS9y6wp3LiJGMWkI0Xe/cljVA0WBws5gYI1QHRp99V33yKGyH+aOA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3h46td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:13:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59859MxQ028041;
	Wed, 8 Oct 2025 09:13:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewn7qwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:13:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5989Dsxl38404354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 09:13:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ABC92004D;
	Wed,  8 Oct 2025 09:13:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CB1420043;
	Wed,  8 Oct 2025 09:13:54 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.14.160])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 09:13:54 +0000 (GMT)
Date: Wed, 8 Oct 2025 11:13:52 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
Message-ID: <aOYrUEr-inqogzJE@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
 <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
 <aOX_L1_2S30XhLRA@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX2SinUPWl76cz
 AjKGe/+vIb6wkkuw6snsxnXWw8uKHTIO5PX8ZtgaWkHm6x2aLt1nN+KYH89EnYoHdv9argm1nwQ
 NlCyOiYHCnWmsi1jz0fXmhUSxgXER53PFSh71pk0g22a6zf1/sPcUrFZk+scMcUxhfUHoXOy23p
 6fWLp5DjrexUoFTp3P/wLrLD5p3Y6fFzdp/Z5QG1xyCBYaQJZulxcKj22WlTp9CvMZpRMbosDhZ
 JvJSubMsHEzKqf3eRyxW3AQbXJnLRP8+KAOKBGD2wsoTrePfW3wMecwgNimPv6vJ9jFKTrxWRsa
 r30WYsftT8s0Hp+3DpEbIeVH/nJgS/pMQdPf/Dr0EoekvSQ8TIpyAdigJOUiyVx4ZLy/pHnCJi0
 QvG7PavYzOhbAbsjv48DHsK/MaI6Hg==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e62b58 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5lHgw4X1gRwckBSjVGgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: frYyvW6OcdJeNiV13t28CQ7UrL4Xa7Gg
X-Proofpoint-ORIG-GUID: frYyvW6OcdJeNiV13t28CQ7UrL4Xa7Gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018

> > > I wonder if the above two are really required. I would expect most/all users
> > > to simply keep using -e / -d.
> > > 
> > > Sure, there might be some corner cases, but I would assume most people to
> > > not want to care about memmap-on-memory with the new model.
> > 
> > I believe this remains very beneficial for customers in the following
> > scenario:
> > 
> > 1) Initial memory layout:
> > 4 GB configured online
> > 512 GB standby
> > 
> > If memory_hotplug.memmap_on_memory=Y is set in the kernel command line:
> > Suppose user requires more memory and onlines 256 GB. With memmap-on-memory
> > enabled, this likely succeeds by default.
> > 
> > Later, the user needs 256 GB of contiguous physical memory across memory
> > blocks. Then, the user can still configure those memory blocks with
> > memmap-on-memory disabled and online it.
> > 
> > 2) If the administrator forgets to configure
> > memory_hotplug.memmap_on_memory=Y, the following steps can be taken:
> > Rescue from OOM situations: configure with memmap-on-memory enabled, online it.
> 
> That's my point: I don't consider either very likely to be used by actual
> admins.
> 
> I guess in (1) it really only is a problem with very big memory blocks.
> Assuming a memory block is just 128 MiB (or even 1 GiB), you can add+online
> them individually. Once you succeeded with the first one (very likely), the
> other ones will follow.
> 
> Sure, if you are so low on memory that you cannot even a single memory
> block, then memmap-on-memory makes sense.
> 
> But note that memmap-on-memory was added to handle hotplug of large chunks
> of memory (large DIMM/NVDIMM, large CXL device) in one go, without the
> chance to add+online individual memory blocks incrementally.

Interesting. Thanks David.

Heiko suggested that memory increment size could also be upto
64GB. In that case, it might be useful.

https://lore.kernel.org/all/20250521142149.11483C95-hca@linux.ibm.com/

> That's also the reason why I didn't care so far to implement
> memmap-on-memory support for virito-mem: as we add+online individual (small)
> emmory blocks, the implementation effort for supporting memmap_on_memory was
> so far not warranted.
> 
> (it's a bit trickier for virtio-mem to implement :) )
> 
> -- 
> Cheers
> 
> David / dhildenb
> 
