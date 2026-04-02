Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A61344D95;
	Thu,  2 Apr 2026 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162629; cv=none; b=Jq4Oh4QxDsUunIryTQ+Ajlx7ImNBYMqRlT1M37RW7tYpLAt7SKg7eKXU/Ma+ecuqEehE/iQ1p1425jL9NrmwsKdCrWdaLy0/Db7AYfHXKZHVjWCzfMahx1W6oIfPeKZeOD3bkRT5dXXe61cjWKgXFE9NIZVDI8luN/z28Jh5F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162629; c=relaxed/simple;
	bh=qmqdy2q57dK7JwqAknOIPc17DNoxrgQFDW63CtKkuH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xnw6FaXBDgivmGiDykKmG6KD+DkivZK6i+2YeEIgeOYJisIyRGig7Ts7uizCEOBJp3pG3b5Y1x8dfXqGa0pZ/4w88+hkHjJo42b4tFtcQyZKC7gHtKKjgqrcZ+4G+Jg+x168qQmlX/3WPh7wqzvK74XrVKGwao+hcLm68iMRw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qck0ggSw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qck0ggSw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632H7F4e1560187;
	Thu, 2 Apr 2026 20:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=7EGJ9edAG+zM/c7jiFIN3LLLHMrt8qLuZrXI4hYikIY=; b=Qck0ggSw8KI4
	eaNrXYelDKnh5YJN2C/Co2mvZJu61TIl7VH16472b/3N7iiwwpbGz9RnVFKahDxf
	lVG2xJvNt8Wey211dYb4WzEOxz6tJey2kzvs84uvpdAftaUP7MIGKBkdtqstrq+I
	Ur8dJAjwOtsfuyikAr5ue/fNI1AmJX3fApbIuJjl+6kG5iaTqvZ78wrgOWNASSwr
	tqZEFfg8ymUl9VDCcEOhVNJ/WIA55qNEWsOpCa5CsJZ8OfQ6+XLlbg10o4hHrAKV
	Eznc3CafbtCWI8sLFC3VMHr5Q+FJaXPUcueHVTTJxz+MOrRJ3YYcBrTvzeFXfVRn
	AAd0SZ3CtA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnxh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:43:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632KOUaA005757;
	Thu, 2 Apr 2026 20:43:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spybr96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:43:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KhiFd28049982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:43:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE0E5805D;
	Thu,  2 Apr 2026 20:43:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD5B958065;
	Thu,  2 Apr 2026 20:43:43 +0000 (GMT)
Received: from [9.61.243.183] (unknown [9.61.243.183])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:43:43 +0000 (GMT)
Message-ID: <b13b12a8-4b89-4931-9cce-f55b5d025760@linux.ibm.com>
Date: Thu, 2 Apr 2026 15:43:43 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: ramesh@linux.ibm.com
Subject: Re: [PATCH v1] PCI: hotplug: Add 'uevent' sysfs attribute to trigger
 slot events
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260401163152.632779-1-ramesh@linux.ibm.com>
Content-Language: en-US
From: Ramesh Errabolu <ramesh@linux.ibm.com>
In-Reply-To: <20260401163152.632779-1-ramesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yB3mkGggO0b4D3GCR5F-Z9FZ1iFe4OoC
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ced503 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=x55IDQzy_rrY38n_pAMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX/TIVR8OTXiSG
 252LScut6t+6oKFYpjZ9DLmeX36EICTE1EBURcHiGLJ2nRSjvuncgBolfv8OawT/BgwPVpzVkXJ
 IUR5m6/WsBffWBPPvqqMuOF/+HSdS/q0SEmlnfNXC57DLNeJQI/vIZxDzZDz4f1v7uSwie2TDvs
 Qc1WEBIFS650ExxMXa/e1rLIH/JnY9xBw6Rbg95FSfsqLXL5RjUC4mVeaKSZRNujDcoOtbTbCyb
 MPCsrD+pL29fvgNilRyuL/1BEiGj6R2QL1lk5nSXVELnSmfIlKFGr7aA7rE3YUtPMExHcguF2aG
 Vq1jc2u1HC6Y4W8lVXzzCdkXMkFsTVySrDC8DPH+wE1dkmfmDZ1mfihZqctrYTsokClWpuWDtuS
 wCAh02HJrsnnEz4/Jj0NmxqhGD+SGiLUEfk/0921NyWm4PtnHVo/sRLPRLVGydJwjUtM2oOs5Rm
 L4XdSXbi85cRZ5v/36A==
X-Proofpoint-ORIG-GUID: g-0KZ5e8nqiUV2aT2QU0eHy_dA6wpLBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020181

All,

I realized this patch should have been sent as revision (v2) rather than 
as new submission. The original v1 that prompted this update can be 
found here:

https://lore.kernel.org/all/20260401163152.632779-1-ramesh@linux.ibm.com/

Thanks,
Ramesh

On 4/1/2026 11:31 AM, Ramesh Errabolu wrote:
> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
>
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
>
>      $ echo "add $(uuidgen)" | sudo tee   \
>                  /sys/bus/pci/slots/<slot-id>/uevent
>
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
> ---
>   drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index fadcf98a8a66..c3634b1cc7a8 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -176,6 +176,21 @@ static struct pci_slot_attribute hotplug_slot_attr_presence = {
>   	.show = presence_read_file,
>   };
>   
> +static ssize_t uevent_write_file(struct pci_slot *slot,
> +				 const char *buf, size_t len)
> +{
> +	int rc;
> +
> +	rc = kobject_synth_uevent(&slot->kobj, buf, len);
> +	return rc ? rc : len;
> +}
> +
> +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> +	.show = NULL,
> +	.store = uevent_write_file
> +};
> +
>   static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
>   			       size_t count)
>   {
> @@ -254,6 +269,11 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>   		kobject_put(kobj);
>   	}
>   
> +	retval = sysfs_create_file(&pci_slot->kobj,
> +				   &hotplug_slot_attr_uevent.attr);
> +	if (retval)
> +		goto exit_uevent;
> +
>   	if (has_power_file(slot)) {
>   		retval = sysfs_create_file(&pci_slot->kobj,
>   					   &hotplug_slot_attr_power.attr);
> @@ -306,6 +326,9 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>   	if (has_power_file(slot))
>   		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
>   exit_power:
> +	sysfs_remove_file(&pci_slot->kobj,
> +			  &hotplug_slot_attr_uevent.attr);
> +exit_uevent:
>   	sysfs_remove_link(&pci_slot->kobj, "module");
>   exit:
>   	return retval;
> @@ -313,6 +336,8 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>   
>   static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
>   {
> +	sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_uevent.attr);
> +
>   	if (has_power_file(slot))
>   		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
>   
