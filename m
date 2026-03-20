Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1D27145F;
	Fri, 20 Mar 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013863; cv=none; b=oT+Zjl39ca2MchIdcuoYgIFoafdNj0k+xpmm3swUW/8nmv+yJ3KV0mVSeV+ByanBcIb1XtsQVOXZKVtscGXpm1AKvjBBAhesIQydrcBXYs4mA/mAA79kAv9bNJ0oEecnmOsTgq99/oVpq1/cgnqd90WDlXyHfkx9iu+7XB4qZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013863; c=relaxed/simple;
	bh=hvDP1vjNyrMFwtAYqYqenouwZCe1TonDtAWVdRE0U44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=c7MY4OB1pS/dIQByZThg4/d63Q8DMmrRmm5FTbvxl7j43ST2P3z2FmsJ0W6VwF+JG97Kx1gNSwvSOmH8Bk5HXrh0HZzf7N5yUDdZihSE1hrvIsBCsnuqU4AL5Wkau4DhueP8crpA1FdGge8lAE495Id4csL2nzJgco/+ke9Ud20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mBb1k6bR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mBb1k6bR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K9Tovm1941698;
	Fri, 20 Mar 2026 13:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vjHkoi
	K/uoJio8JabPeTbS3btk5225hcYcUMMFhRdNw=; b=mBb1k6bRbsjEaOlAgWSI1h
	TNNrTWBN5czog36oIVjcjRHZU/3gg7rEl7+txr0mxmscXgUDpZu+greuK7MZZDKr
	HFPUb+JcExoNUab3+GSAW3LrJLVexUcV0MjnUw3vdLw2qxtyvDQ+HSXGDr/GjB0m
	v1wtvlCt4gpUEWnq0ApEIuNfV8xV3gF1BfVHAZFXMm484P9tPsbqhTKbRaOVwsk3
	qOSPU3RkPGx5Lxuh5pp/ZrPewJrMMmUqz6YFiQtozJGAmC03PMsi4aF4PT9Q3XPW
	77XZttq8sX3fF0GM2AAKNCb02f8K7xUGC8JR2rKIRn6Yaz9pRfo+r/TtjV+t+yjQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy653x0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:37:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KCaY3l015655;
	Fri, 20 Mar 2026 13:37:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nqav7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:37:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KDbWq056426866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 13:37:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EBFA2004B;
	Fri, 20 Mar 2026 13:37:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F1320040;
	Fri, 20 Mar 2026 13:37:32 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 13:37:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 14:37:31 +0100
Message-Id: <DH7NFCRHDMI3.1S64YUGRBH7O8@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Julian Ruess"
 <julianr@linux.ibm.com>, <wintera@linux.ibm.com>,
        <ts@linux.ibm.com>, <oberpar@linux.ibm.com>, <gbayer@linux.ibm.com>,
        "Alex Williamson"
 <alex@shazbot.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, "Yishai Hadas"
 <yishaih@nvidia.com>,
        "Shameer Kolothum" <skolothumtho@nvidia.com>,
        "Kevin
 Tian" <kevin.tian@intel.com>
Cc: <mjrosato@linux.ibm.com>, <alifm@linux.ibm.com>, <raspl@linux.ibm.com>,
        <hca@linux.ibm.com>, <agordeev@linux.ibm.com>, <gor@linux.ibm.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
 <20260319-vfio_pci_ism-v6-2-c6bab675bc0a@linux.ibm.com>
 <18f44f67f096e0003d4083da20e2ace4c118c2f4.camel@linux.ibm.com>
In-Reply-To: <18f44f67f096e0003d4083da20e2ace4c118c2f4.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xNPB83XAUwIoKWbMAtt7SyhcoymxBKdk
X-Proofpoint-GUID: xNPB83XAUwIoKWbMAtt7SyhcoymxBKdk
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bd4da1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EmJ8IPxNXi14PtKF6o8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwNCBTYWx0ZWRfXyQvYmyQY0bM5
 +C1CCqv4fEQ6BZNWyHKzF6eW8KfjoFxuQvCCavGbfknHvS8jhIVD1Z4XAgpacUEN83zv7OS/qhW
 wYse1O6dAO7uKddAYD16z3qaB4CTpNhuOo6dyZ5LR2HTDWIEOx45gJulL9Movvtghh1zbNyJt1Z
 fp2a8psMD99USV1Zzk4+ffwvpbhFW0EhcHNAXGtO+o35rDM41tSdeO+35rpGEFFD5BBQBXodkVL
 NzHB5Vui9+XQcZS63oiG8ONNKLPsUMX8/yafZej7dYCh196R76wOn5I968gmPDJlHpUWVqPd7da
 NUaP4hcLWtAsZvYLrtglHdeVVKeaCm33/cNj1PpgzNErw9/jtMbk8RT46cUCb/IHFfy0xBO+7Ae
 BE/uda7pSJi3Oyt8ruMuxIgZAP2GpmGBA5xAsHKv1tttd9w/vNwrrXGnFADA1du7YklbxhKWmWh
 radhP8AvJP0plIB+qRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200104

On Fri Mar 20, 2026 at 1:54 PM CET, Niklas Schnelle wrote:
> On Thu, 2026-03-19 at 16:42 +0100, Julian Ruess wrote:
>> Add a vfio_pci variant driver for the s390-specific Internal Shared
>> Memory (ISM) devices used for inter-VM communication.
>>=20
>> This enables the development of vfio-pci-based user space drivers for
>> ISM devices.
>>=20
>> On s390, kernel primitives such as ioread() and iowrite() are switched
>> over from function handle based PCI load/stores instructions to PCI
>> memory-I/O (MIO) loads/stores when these are available and not
>> explicitly disabled. Since these instructions cannot be used with ISM
>> devices, ensure that classic function handle-based PCI instructions are
>> used instead.
>>=20
>> The driver is still required even when MIO instructions are disabled, as
>> the ISM device relies on the PCI store block (PCISTB) instruction to
>> perform write operations.
>>=20
>> Stores are not fragmented, therefore one ioctl corresponds to exactly
>> one PCISTB instruction. User space must ensure to not write more than
>> 4096 bytes at once to an ISM BAR which is the maximum payload of the
>> PCISTB instruction.
>>=20
>> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
>> ---
>>  drivers/vfio/pci/Kconfig      |   2 +
>>  drivers/vfio/pci/Makefile     |   2 +
>>  drivers/vfio/pci/ism/Kconfig  |  10 ++
>>  drivers/vfio/pci/ism/Makefile |   3 +
>>  drivers/vfio/pci/ism/main.c   | 400 +++++++++++++++++++++++++++++++++++=
+++++++
>>  5 files changed, 417 insertions(+)
>>=20
>
> As a general note, ISM devices do not support any low power/sleep modes
> which is why there is no PM handling done.
>
>> +
>> +/*
>> + * ism_vfio_pci_do_io_w()
>> + *
>> + * Ensure that the PCI store block (PCISTB) instruction is used as requ=
ired by the
>> + * ISM device. The ISM device also uses a 256 TiB BAR 0 for write opera=
tions,
>> + * which requires a 48bit region address space (ISM_VFIO_PCI_OFFSET_SHI=
FT).
>> + */
>> +static ssize_t ism_vfio_pci_do_io_w(struct vfio_pci_core_device *vdev,
>> +				    char __user *buf, loff_t off, size_t count,
>> +				    int bar)
>> +{
>> +	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
>> +	struct ism_vfio_pci_core_device *ivpcd;
>> +	ssize_t ret;
>> +	void *data;
>> +	u64 req;
>> +
>> +	if (count > zdev->maxstbl)
>> +		return -EINVAL;
>> +	if (((off % PAGE_SIZE) + count) > PAGE_SIZE)
>> +		return -EINVAL;
>> +
>> +	ivpcd =3D container_of(vdev, struct ism_vfio_pci_core_device,
>> +			     core_device);
>> +	data =3D kmem_cache_alloc(ivpcd->store_block_cache, GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(data, buf, count)) {
>> +		ret =3D -EFAULT;
>> +		goto out_free;
>> +	}
>> +
>> +	req =3D ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, count);
>> +	ret =3D __zpci_store_block(data, req, off);
>
> Note: There is a Sashiko finding that PCI Store Block needs 8 byte
> alignment and we don't ensure that off is 8 byte aligned here. While
> generally true the ISM device has relaxed alignment rules and this
> requirement does not apply. That said we should set PAGE_SIZE alignment
> on the kmem_cache such that data is guaranteed PAGE_SIZE aligned and
> the page crossing check works correctly.
>
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	ret =3D count;
>> +
>> +out_free:
>> +	kmem_cache_free(ivpcd->store_block_cache, data);
>> +	return ret;
>> +}
>> +
> --- snip ---
>
>> +
>> +static int ism_vfio_pci_init_dev(struct vfio_device *core_vdev)
>> +{
>> +	struct zpci_dev *zdev =3D to_zpci(to_pci_dev(core_vdev->dev));
>> +	struct ism_vfio_pci_core_device *ivpcd;
>> +	char cache_name[20];
>> +	int ret;
>> +
>> +	ivpcd =3D container_of(core_vdev, struct ism_vfio_pci_core_device,
>> +			     core_device.vdev);
>> +
>> +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid)=
;
>> +	ivpcd->store_block_cache =3D
>> +		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);
>
> Sashiko notes here that the cache_name is stack allocated and says that
> kmem_cache_create() doesn't copy it. Looking at
> __kmem_cache_create_args() however this seems to be not true as that
> does krstrdup_const() on the passed-in name.

I think we should change this to:

ivpcd->store_block_cache =3D kmem_cache_create(
       cache_name, zdev->maxstbl, PAGE_SIZE,
       (SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT | SLAB_PANIC), NULL);

The alignment ensures that we do not cross the integral boundary, and as
Sashiko said, memcg accounting is also useful here.

-- snip --
