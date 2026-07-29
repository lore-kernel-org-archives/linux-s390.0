Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C343E1226;
	Wed, 29 Jul 2026 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357371; cv=none; b=YKK+o04ftA71aG8xdLUYLrRZSaaIxF7CBiyIrKhmiu2toFvZri2tFQPM71ddYUU7Jpex+wA88Lmay+EpUngXJrpAflw9cjbyT1CWE0yDqMx4pZ1nsDpxpF/SXbc4AMTUn7PGYakA2CEcj0etX5UuQMR6mYKXSwfZG9hhopMv/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357371; c=relaxed/simple;
	bh=YHL7ZD6IQB5+BZcmiSJFZhSGM56v3nP6G5oEZpmyuV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYFWUJgcLFBeRCsaFC9b1EZLZFDgoSlxY5m8o2KSuhUHlR7JerQs5GVkoWBL+EW0ZlBf5+OXGOKM0aqBs35QEipMtHPmzvSAoZeVTvN7UpNgDYuQDynOUULLkmaXSZpQ8IPOolJMfR2MHDBl7+Ym2nxk9cooQoyXhbhNpydEpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ASPACXzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VhQdDVKT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ASPACXzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VhQdDVKT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CCA5DEC0576;
	Wed, 29 Jul 2026 16:36:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 16:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785357365;
	 x=1785443765; bh=VVJdTLW0XaIoP+oi8isAvMFYxiJ6/s4KOB+fFqHPCU0=; b=
	ASPACXzj8icJmBkG87F5nTIFo1eP4KV5FU/qCoh9CPgJeNrWEYr5CsEeo2f1owER
	PX6qKofeARJPUxa19sifYc1AesAhNBMUUPbzJ2dZagjkd/oajBDivU1ypSdCo2ZE
	u0lf0zfru5R08TBeQrKMLyd34QuuQ4PZnH+UWbwLZddS5Neaxqov5kiHvNx/SBS/
	k2iDyoGZTVQy95qlsI+YpDpayXkLrEIR1H0VWc/u6EONH9rqiYERF4twBfvH+APj
	pOt64MlnNfjXIZC4K/TIo7hIAiwxatBwM+gAD9rX2NK070tUoW9xy7k90/U64NwH
	ry7+4kyYlED1wdOmHbd6yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785357365; x=
	1785443765; bh=VVJdTLW0XaIoP+oi8isAvMFYxiJ6/s4KOB+fFqHPCU0=; b=V
	hQdDVKT+EeA83hp6vP6GqlvXpC4nKgmCbTM+E5gcJ+vwsHDGSjIccuqzmEUOl1+6
	jg4b3IT5TlWLVt1Pj9iuf1pXjoE+f+P4r2ALSpiTNvYGQy27WafqLv8AqiTPSDD7
	Ysnk6aW/G2ht/s/MkJP2locasQzWdADSoiuaAXwkEaziNbQqJZ+AcL7vFxb7AePM
	gMc0GNq1s9fhGF6UmJVrfsiLMOOP2PHbKGATiEWgfSQcFko34nKKv/1DSpTEF+tJ
	JWOyHYBr1sEJjb3MYxAS7U1snB0tubH5Xz0y2kLhgf9c7ew6TcVubgBb73RKQ0VY
	O0Igh9CSg9taVoeVvEXvA==
X-ME-Sender: <xms:NWRqagYteBPguaKk4Nrgp_fVInFpmfaeMz6gG8k0KU2y3To47QxLxA>
    <xme:NWRqajmgmLqZ6dlKZcKSeyB6Z7gWXO9Cu2uXEZaF4hWlDYO2jaukj-NLAvcrsk_0i
    DIlXoLHVER0b9VkjThRrO1mWnGmdoiGJdoC0noOa8QvwR2Yd5BCf94>
X-ME-Received: <xmr:NWRqamgw9j5o_1ZHznXUgr32Aeb31OZQNtJnS5ODvD6abzK19ZnLXRYbmB5Alg>
X-ME-Proxy-Cause: dmFkZTF5joDESc+IKSOSrepkbuheblPyY5dq9qzqwT3frG3oX0lljCt9wDRX/f8thcowYS
    4hQ99bagzIV7gWuGMPMC2XvMY+uuH4nO48bbyEXcg9j2btNN3XRt8FFEXBxJc2JjCE6Sx9
    K0eHgMAcNFenhlx6eHtkFX38tni0Si2qxXaq5LtXZPd4Q7vlx8gIYcjBnPyl8ZsyXzhRvp
    4vNrmRTUYeC7j0Ri3Fv9dd2ghkYS7u2+pRIFfA/YJNCAWuAmUTKQma7CgjgF4bSxhL3pW0
    hgtR30HcLGElaD8ydvovi4SLDFxcYUdqvZmRE1+NAjNSIM9Hg9GgG8j9/ogK3ehDYdlGnc
    aVAQ5XCpPEfWPmHp271RDmsIwuNhxMh6pvWGBmxFGyRgAAe0NNoDBmrf3069Db8WvKpV1H
    ymH3giBhenYMIyCYi34xqQT9X9pCZ2VzkEsb6t/HzGk7FXWRbmjS8MaBOcOFOD+gv5SuW5
    Pv7/J6f8smQuVJy9PLPxqSWHR50dsY91CYuCUj/UtZF1M7ho+RFNS5E0eY/0HAZpwY7fh3
    RzLBORShYixGMH4rPS7BB0nzbzdQqtp4rtFcVV2fUt4Iqid2M2PJhWjC6JMNonExV6rnLK
    rpCiwIXgNphL2IWwtj6V3/+DLHxSlSWoMfinhs4MMloiviIq4/9rMeCrtm2w
X-ME-Proxy: <xmx:NWRqalSSqDAijr1aOyr2zsDMfp0yqSrqEeEkaY2jlemzxqivj8GIFg>
    <xmx:NWRqanYJ_N9-LVVDpZXz-hhQ7hR8iPNIZg4c1glMSQsFX3amFRxoSg>
    <xmx:NWRqaiTefNLvyNxRUpxxQf7zUKRV-y_x3GDyduuNywAA1aXMX2e-Qw>
    <xmx:NWRqam8Iup8hSlLxzCBB-5q4tnz48XPj8M5w3OomcvColQTYUfIWrw>
    <xmx:NWRqasa_VfXD2xP8Uybtco3FH-umnhYuVZSYYZF5yCCWbY9xtIBlJsh6>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 16:36:04 -0400 (EDT)
Date: Wed, 29 Jul 2026 14:36:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@linux.ibm.com,
 mattev@meta.com, schnelle@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
Message-ID: <20260729143603.175f60a7@shazbot.org>
In-Reply-To: <46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
References: <20260729181116.1373-1-alifm@linux.ibm.com>
	<e7b2da7b-2c70-46c2-9d07-6acc6949915e@linux.ibm.com>
	<46fede14-a740-4d66-98b3-c840e03e8634@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 13:28:46 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 7/29/2026 12:41 PM, Matthew Rosato wrote:
> > On 7/29/26 2:11 PM, Farhan Ali wrote:  
> >> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but not
> >> all devices support having their BARs mapped by the CPU. The
> >> non_mappable_bars flag indicates that a PCI device's BARs cannot be
> >> accessed by the CPU. The ISM device on s390 is one such device. The BAR
> >> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
> >> to warnings:
> >>
> >> vmalloc_node_range for size 281474976714752 failed: Address range
> >> restricted to 0x2110bab00000 - 0x21903ab00000
> >>
> >> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This flag
> >> is set by the PCI core at enumeration time and already serves the same
> >> purpose in vfio_pci_probe_mmaps().
> >>
> >> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()")
> >> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   drivers/vfio/pci/vfio_pci_core.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 3f11a9624b9c..6a184588ff23 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -554,6 +554,9 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> >>   
> >>   		vdev->barmap[bar] = IOMEM_ERR_PTR(-ENODEV);
> >>   
> >> +		if (pdev->non_mappable_bars)
> >> +			continue;
> >> +  
> > This would work for the ISM case at least, but I wonder: should we check
> > vdev->bar_mmap_supported[bar] instead?
> >
> > My question boils down to: do we still want messages for some of the
> > cases where we set vdev->bar_mmap_supported[bar] = false in
> > vfio_pci_probe_mmaps()?  
> 
> AFAIU vfio_pci_probe_mmaps() is only called in 
> vfio_pci_core_finish_enable(). Since vfio_pci_core_map_bars() is called 
> in vfio_pci_core_enable(), and before vfio_pci_core_finish_enable(), 
> bar_mmap_supported would be false here for all devices. So I don't think 
> it would work here, unless I missed something?

Also IO Port and sub-page MMIO BARs are things that do exist.  Thanks,

Alex
