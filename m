Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A777346FAA;
	Tue, 31 Mar 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978916; cv=none; b=YbRLG4ewSf9ww5Qpr4aWKQP/YS/N9WcMKKzDUAoaVyz5cIZnv3G3Dqh5gXslREBWBJwvNtjkWrSnMUBbavdnHKzlDv/91gmOve4edpPG2kwQ4iJo7LoK+YG+T9Fuq10wNJqdngKsHuapMuTkzEhUuEFGGTc3vbCJqz21qn4RC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978916; c=relaxed/simple;
	bh=TGR+HLPBh0kT8UPVJ1fWokPpIZZT2ea97q58XkGX8lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYEOojXw4FrINIr702q8NezlXF2NfSEEaG8lAOEBWfs8M6kuqR/t5okqrLcyBYNCPrO5jnP9vdBoyPN5XZSQbEP0L+QJgy8tQ7YiwBkJxUsuYGJUX3/oCHZ0PZ+0qX52EkCe3SfPlr9GdXkjp09gfY+X37E6q/Kdc7SM9ItQz2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LdNAua3Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LdNAua3Q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VA6dcr346198;
	Tue, 31 Mar 2026 17:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T/vrPU
	g0UXAok1MOifcTEF57XHm+sL7oT2IEn/MCpX0=; b=LdNAua3Qr9EaePygF71yW0
	ixVTYgasOWIkgPyQggs7jpdc7M/wNvN41I2Kd+aTWW/7naiK+hw6Y1UVQnkfFjDd
	wDiidOYiPTc1a4l8A2VJcl2GTn6XbbZdBHTbOgLtLSLxRyfMZ9SYVMNMQNrlNTn5
	D2YKfi5ENPfbnJGKDaosr0FruMA2PKDEFtSrFHwBDQVOcwnzP+2TDL7BVSoED+CA
	Jjm7hgbretPatL82NTdQ6Xbc3imS7piy9vrXZMXAwYPHbfUt6c7wMROH0mdG8sZS
	MiOk8CTMsGQDQPENvQNPCkBBSpas/mqjf47VfTejN5ve4nxgEcbVGl5hLRS7K/Gw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms42b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:41:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VFAoU5005952;
	Tue, 31 Mar 2026 17:41:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy29vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:41:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VHflUt31851234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 17:41:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B31E5804E;
	Tue, 31 Mar 2026 17:41:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 347565803F;
	Tue, 31 Mar 2026 17:41:46 +0000 (GMT)
Received: from [9.61.9.136] (unknown [9.61.9.136])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 17:41:46 +0000 (GMT)
Message-ID: <8c080d9b-34f6-469c-8e53-c5d0a175556d@linux.ibm.com>
Date: Tue, 31 Mar 2026 13:41:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, schnelle@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-5-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260330174011.1161-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cc075d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=1P5juWRcwJ_tNLV9FsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2NiBTYWx0ZWRfXyn4KtCXD4K+r
 HMcM0yTpMnbdi4OM8JVc+lGNZPijYH8gs1GT5qfX0pmnoVZPLJlduIv4B7uaZumF8SfJQACeSYs
 KOrL7qvWeyHgYp2uoUpsjgY7/FlTS2mRDs/5UF+a1jJ5tS+clXGbNHLLigk+7nlW6X0Bm2U5Q6E
 XNjB+iNKhDVEAud4UrD4OHyNDfmrKUqakQhWQTiC9PO9PGbty3ZE7z4hcmo7pUBmw6HRmWNdTU8
 skaPAmNkurh1ZoRXTnCFsruFiBqsgKYqGnlyzbn4LrqMAPV9rSyHkW9nCd6GMs8LouhR6E22jHm
 UHRHW63MvIDvE0K0z+wPpEWWGgenTCSaQT3FaOJPU43JjCf+tJdOehRpTmG4BrmfeTOz+CHlCmN
 nEhClin4eF6f0fkvyELVcgaWGfV8z+quJN5p5jmq98A2hrg3FSTaq5cZgYF8GQaRV6N+ZRAvcgE
 uTLMTfRTf5PiJnABSsA==
X-Proofpoint-GUID: b_ES92DVImBfbcV8Yo6zs98SGrnkjHlC
X-Proofpoint-ORIG-GUID: b_ES92DVImBfbcV8Yo6zs98SGrnkjHlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310166

On 3/30/26 1:40 PM, Farhan Ali wrote:
> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
> 
> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depend
> on struct kvm_zdev.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

But a suggestion below:

> ---
>  arch/s390/include/asm/pci.h      |  30 ++++++++
>  arch/s390/pci/pci.c              |   1 +
>  arch/s390/pci/pci_event.c        | 113 ++++++++++++++++++-------------
>  drivers/vfio/pci/vfio_pci_zdev.c |   9 ++-
>  4 files changed, 105 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c0ff19dab580..7fb9a80b0175 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -118,6 +118,31 @@ struct zpci_bus {
>  	enum pci_bus_speed	max_bus_speed;
>  };
>  
> +/* Content Code Description for PCI Function Error */
> +struct zpci_ccdf_err {
> +	u32 reserved1;
> +	u32 fh;                         /* function handle */
> +	u32 fid;                        /* function id */
> +	u32 ett         :  4;           /* expected table type */
> +	u32 mvn         : 12;           /* MSI vector number */
> +	u32 dmaas       :  8;           /* DMA address space */
> +	u32 reserved2   :  6;
> +	u32 q           :  1;           /* event qualifier */
> +	u32 rw          :  1;           /* read/write */
> +	u64 faddr;                      /* failing address */
> +	u32 reserved3;
> +	u16 reserved4;
> +	u16 pec;                        /* PCI event code */
> +} __packed;
> +
> +#define ZPCI_ERR_PENDING_MAX 4
> +struct zpci_ccdf_pending {
> +	u8 count;
> +	u8 head;
> +	u8 tail;
> +	struct zpci_ccdf_err err[ZPCI_ERR_PENDING_MAX];
> +};
> +
>  /* Private data per function */
>  struct zpci_dev {
>  	struct zpci_bus *zbus;
> @@ -171,6 +196,7 @@ struct zpci_dev {
>  
>  	char res_name[16];
>  	bool mio_capable;
> +	bool mediated_recovery;
>  	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
>  
>  	u64		start_dma;	/* Start of available DMA addresses */
> @@ -192,6 +218,8 @@ struct zpci_dev {
>  	struct iommu_domain *s390_domain; /* attached IOMMU domain */
>  	struct kvm_zdev *kzdev;
>  	struct mutex kzdev_lock;
> +	struct zpci_ccdf_pending pending_errs;
> +	struct mutex pending_errs_lock;

This mutex now protects the pending_errs struct (obvious) as well as the
mediated_recovery bool (not obvious).  Add a comment here and/or as a
block before the needs/start/stop functions?

Actually..  Could mediated_recovery just be part of the
zpci_ccdf_pending stucture?  AFAICT the bit basically controls whether
or not the zpci_ccdf_pending structure is used / has meaning.  You even
turn the bit off at the same time you memset(&zdev->pending_errs, 0) in
zpci_stop_mediated_recovery() -- though an explicit setting of
mediated_devices = false would still be nice for code clarity.

Then the spinlock continues to protect only this structure.



