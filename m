Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5E3CCA0C;
	Fri,  3 Apr 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236809; cv=none; b=V4svs6g2GJXdd6Oj1eESoqIrbR/F5MJFeTU7MgBNfFIyZgzHgvElTqlvl2y/jrihL163SP34R39b53vozCPsG1rxB76kgoy7PeGxo4wtPRkm9aPaldC0NN3Ve7rFp1ww6Wil2kKJ8GThrFDxnwNY6LrVHPC8Z+qyO/5LqTlEhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236809; c=relaxed/simple;
	bh=7HUxjHlLX7tKAP5UZ9w1O1GhJcWKtKba8jFl34koW54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUyogjjyLQj2WyHfXwz/PXypbddoL3tH/PF+YXuXR1vS59DnGhG2Fn1LEdjVcg1KZoq8JuLOZLASZqZKvmuNT2OIfxxLbzJ6ufr22LDlKNKwUb5T+UQgT9+ru9pBTXCI/1ymz58RaKPfRrcsaD1CPiPKYfZ8G+A8KuLlf69DQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZaItZL4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZaItZL4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632MX4Q13676159;
	Fri, 3 Apr 2026 17:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bekqmO
	ottmfu/C/eY2bs7mtQZVOoQW7nKirlmasQaKs=; b=rZaItZL4lXE1udtUzBHW0E
	xnOlEaBrQwTDgl1pPkyPto0Ux6HF+yB1zxxauZAS3NzPHTtSxpsEIn2IC6KqYO4L
	XDjOu8UKChc7+PI/EMFXlXpxp+i4M+a1H4ACnaivYauPnZMQynzaQxh3qM4RLo7s
	Ak6l+5hETmtPiNogWco8tQhupLkwCvcdxYbaZHSsSG9P96KtUwkJGh0YiME2qzL0
	HoSQ8OeHkehhc+Ldk0jELUziP/HcOPCz9iogrD//f3mlSuQ+y6fsfPX/gKPX5Gc4
	/fz+MpkDcr2GC5Ps0C64l6x7Xkhfh856NlFx914ujaFXNd5pdYic80jCzlHmtOsw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msghj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 17:20:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633EhATV008703;
	Fri, 3 Apr 2026 17:20:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11xn7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 17:20:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633HK1Ig20251350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 17:20:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7197058053;
	Fri,  3 Apr 2026 17:20:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17E558043;
	Fri,  3 Apr 2026 17:19:59 +0000 (GMT)
Received: from [9.61.255.240] (unknown [9.61.255.240])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 17:19:59 +0000 (GMT)
Message-ID: <bde50f9a-bbe1-43ba-b2f4-24951dd0cccf@linux.ibm.com>
Date: Fri, 3 Apr 2026 10:19:59 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
 <20260402-uid_slot-v6-2-d5ea0a14ddb9@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260402-uid_slot-v6-2-d5ea0a14ddb9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cff6c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zab_MO1Yg7CTISiwoJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1NCBTYWx0ZWRfX5LQFWOEzEKoj
 sv9QIsXSkhcl9+YSN1NNR1mene1qjziSaxZZ7/4Demu9AojEBiEEqbpoN/+vBWJtNciwqFwdV8X
 S2taKkVsx23y7yoUAemgnncRAMTZ4AkBgXCAxFRtwHDYjdLc7Ck69Ig4dLHdWonOMmvhvO6o4jL
 Qz7D2Qcfh0Oboe8aAnvJMQ813JQj8EUrL6BWneN+g/Lzmol/QzMFqZFbno+SEopEPCJqo3Qo175
 wyEzciK4c8xxqWaVyJ/zBsPYfuKezqdqN8t36AJRQeLmtSSOaUWzQEL6647lzF3+5sCQSGIPK67
 NPnm4EpKLqzVCG1xlkeRL+Tn8HdLPg5grbzWcn5aTlonnGwYxp61fdCz+6GAEKH7N+2nTL9v4q9
 cNobk3epuDFDBkPEkybq0zm2woqh1vroasReDwy4vRQlK5xHyZgKW7KkTcHZ4zoOXcPWTsvBi8Y
 pZ0jsI13F1tS6CuRj/A==
X-Proofpoint-GUID: ttKxjis-mUI1CHId1Ow0JEo2NRbZ3Qse
X-Proofpoint-ORIG-GUID: 7HTSU5BayCQorpXQvpwkBPttdMaWSRRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030154


On 4/2/2026 1:34 PM, Niklas Schnelle wrote:
> On s390, an individual PCI function can generally be identified by two
> identifiers, the FID and the UID. Which identifier is used depends on
> the scope and the platform configuration.
>
> The first identifier, the FID, is always available and identifies a PCI
> device uniquely within a machine. The FID may be virtualized by
> hypervisors, but on the LPAR level, the machine scope makes it
> impossible to create the same configuration based on FIDs on two
> different LPARs of the same machine, and difficult to reuse across
> machines.
>
> Such matching LPAR configurations are useful, though, allowing
> standardized setups and booting a Linux installation on different LPARs.
> To this end the UID, or user-defined identifier, was introduced. While
> it is only guaranteed to be unique within an LPAR and only if indicated
> by firmware, it allows users to replicate PCI device setups.
>
> On s390, which uses a machine hypervisor, a per PCI function hotplug
> model is used. The shortcoming with the UID then is, that it is not
> visible to the user without first attaching the PCI function and
> accessing the "uid" device attribute. The FID, on the other hand, is
> used as the slot name and is thus known even with the PCI function in
> standby.
>
> Remedy this shortcoming by providing the UID as an attribute on the slot
> allowing the user to identify a PCI function based on the UID without
> having to first attach it. Do this via a macro mechanism analogous to
> what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> pdev->dev.groups") for the PCI device attributes.
>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   Documentation/arch/s390/pci.rst |  7 +++++++
>   arch/s390/include/asm/pci.h     |  4 ++++
>   arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
>   drivers/pci/slot.c              | 13 ++++++++++++-
>   4 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
> index 31c24ed5506f1fc07f89821f67a814118514f441..4c0f35c8a5588eee3cf0d596e0057f24b3ed079c 100644
> --- a/Documentation/arch/s390/pci.rst
> +++ b/Documentation/arch/s390/pci.rst
> @@ -57,6 +57,13 @@ Entries specific to zPCI functions and entries that hold zPCI information.
>   
>     - /sys/bus/pci/slots/XXXXXXXX/power
>   
> +  In addition to using the FID as the name of the slot the slot directory
> +  also contains the following s390 specific slot attributes.
> +
> +  - uid:
> +    The User-defined identifier (UID) of the function which may be configured
> +    by this slot. See also the corresponding attribute of the device.
> +
>     A physical function that currently supports a virtual function cannot be
>     powered off until all virtual functions are removed with:
>     echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c0ff19dab5807c7e1aabb48a0e9436aac45ec97d..5dcf35f0f325f5f44b28109a1c8d9aef18401035 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -208,6 +208,10 @@ extern const struct attribute_group zpci_ident_attr_group;
>   			    &pfip_attr_group,		 \
>   			    &zpci_ident_attr_group,
>   
> +extern const struct attribute_group zpci_slot_attr_group;
> +
> +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
> +
>   extern unsigned int s390_pci_force_floating __initdata;
>   extern unsigned int s390_pci_no_rid;
>   
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index c2444a23e26c4218832bb91930b5f0ffd498d28f..d98d97df792adb3c7e415a8d374cc2f3a65fbb52 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -187,6 +187,17 @@ static ssize_t index_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(index);
>   
> +static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
> +{
> +	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
> +					     hotplug_slot);
> +
> +	return sysfs_emit(buf, "0x%x\n", zdev->uid);
> +}

I think the way we assign the same pci slot to multifunctions (PF and VF 
on the same LPAR), IIUC we could possibly display the wrong uid here. I 
am hoping my patch [1] can fix this. I am curious, is there any 
s390-tool that would use the uid? Though this would only impact the NETD 
devices on newer machines, so I don't know if we want to gate this 
behind my patch?

[1] https://lore.kernel.org/all/20260330174011.1161-2-alifm@linux.ibm.com/

Thanks

Farhan

> +
> +static struct pci_slot_attribute zpci_slot_attr_uid =
> +	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);
> +
>   static umode_t zpci_index_is_visible(struct kobject *kobj,
>   				     struct attribute *attr, int n)
>   {
> @@ -243,6 +254,15 @@ const struct attribute_group pfip_attr_group = {
>   	.attrs = pfip_attrs,
>   };
>   
> +static struct attribute *zpci_slot_attrs[] = {
> +	&zpci_slot_attr_uid.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group zpci_slot_attr_group = {
> +	.attrs = zpci_slot_attrs,
> +};
> +
>   static struct attribute *clp_fw_attrs[] = {
>   	&uid_checking_attr.attr,
>   	NULL,
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 787311614e5b6ebb39e7284f9b9f205a0a684d6d..2f8fcfbbec24e73d0bb6e40fd04c05a94f518045 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -96,7 +96,18 @@ static struct attribute *pci_slot_default_attrs[] = {
>   	&pci_slot_attr_cur_speed.attr,
>   	NULL,
>   };
> -ATTRIBUTE_GROUPS(pci_slot_default);
> +
> +static const struct attribute_group pci_slot_default_group = {
> +	.attrs = pci_slot_default_attrs,
> +};
> +
> +static const struct attribute_group *pci_slot_default_groups[] = {
> +	&pci_slot_default_group,
> +#ifdef ARCH_PCI_SLOT_GROUPS
> +	ARCH_PCI_SLOT_GROUPS,
> +#endif
> +	NULL,
> +};
>   
>   static const struct kobj_type pci_slot_ktype = {
>   	.sysfs_ops = &pci_slot_sysfs_ops,
>
