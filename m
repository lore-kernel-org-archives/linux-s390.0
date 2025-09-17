Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D5248F68
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090126; cv=none; b=epflZAfQSdOiDmb/4u9PO4Lab/F8h38CTXgTwr2X8VJPVqK0tTwhixCLPimxhLItO9O+vD1Iv8K6j+RhSpyUnMGy31QMWC50YtWb2pv5YvdNPJfzOpb/dYt+/tQ1gHfAlD69Mfkc5/ywrrQR4skC0AjUKyFxBYzvUG6sYOCBnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090126; c=relaxed/simple;
	bh=Kjn7elBlJ9GDdMgXC2HuQsesFr1yau8WiLp8/P3iHa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPnjGR43t0yxHDb8kWdPpalhfbKELJMaO9lUBZ2L+eD4kXJDZwPOzfjy4maY67+9CGqP7/363BWb68a5S2FxWNSjyZaKFY2hgZs0jw3vJQ+8jUDCmE6EYuVi+Em44Ri0OaA/ChzoPRaaWdUMngkTEX7e7K7NDIy5EkggCbAnK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpeFTEhk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpeFTEhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758090123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ykBGuqrBMlcXxL95pIhOkq4MfPjBUjAZXEQ/nbR5dCs=;
	b=TpeFTEhkTytsKM+LWmzL5eRFdQrnrVgVakVwLrGHk9C/Dp+OB28OZ42sjl2m0b8ZR2s4/6
	Hb9PZM6KmyiyURsAohrREt5BZWks1IpeqFWl0XkN2BkmFcxnq7nNypPMnl4KRWHM0kMKgN
	Ycf6nne0FzDlZ2L9PbfnWgSkoGMR2q4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-TtS0CclzMU-j0gHDCaRRUg-1; Wed, 17 Sep 2025 02:22:02 -0400
X-MC-Unique: TtS0CclzMU-j0gHDCaRRUg-1
X-Mimecast-MFC-AGG-ID: TtS0CclzMU-j0gHDCaRRUg_1758090121
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eb72c3e669so1445066f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 23:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758090121; x=1758694921;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykBGuqrBMlcXxL95pIhOkq4MfPjBUjAZXEQ/nbR5dCs=;
        b=jNFq6LoVrGseTZjJ/dbyBs2aIhPWba26y4r0oQOTBl8Sol10H0oTlg1u18b2ksDHdw
         4bRriSYEphJLBloqV1rcWg7RLfqvgPvYhwXKrzqo0AxumWcPcy6+7SpUcMD/eJOqngHH
         tW7EXlZZQNkQd9f1KzXLYXwrsXinsB3Lg5mUIZ5mx5QQNHwrOMBlLkDos6MO83W4/k+m
         o1klXWxOLx6yfE2Qy/yxcjBh5N4iRcEvkK06stm1ASWAY1kNQ/xiFlQXPnTqP/TaDvTA
         xoCoYwfkbP2tnpQLer/elduQZmRyHeLxE34NSwbBjjtz8PE8loBFTSD1ottjiR1Rr55R
         F9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXTgnrwLKR9y7y8oxA9nGtgqCfEMJl3G+0Osf1CY7kkwoRGSLNNwWSGszgrFaAYA2AVGJqtLU8n5NwO@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLRsBUqo/INCOBhL7hF8LNJO9Eo2zAFCU5iCgioklhO07aDm1
	1l1t75mp6gAmiol3ih2IZfr31SgyoXepYxvSh8jM6GDJ3yX9klNp504fIwNJQBfijm4K6qF7UoF
	xAoRBPyYz0iDQE8wtz7NNcy5KcqP8nuW3UQygNcUdf3tFxaDZBfTAUpnll3tzyyc=
X-Gm-Gg: ASbGncsZkMAxGa58+ITu9Du0FIt0nPZhCTLcDC2APxhPYamaw1RmHUpcAIZEVFfrYKU
	nhuj8ity1HDQ96zAVyC3d5hrP6+tgbRNiRNegCi8Gpelo6D61NrydQxHMi1YG2A54H6E27PuzT3
	r+iLbijyDmXzQy1zsrQwOQGIbqUHNP82p+h6K8Im+pbl47D4j2QJdaQ9FBsXu6M63zqfD58Rq+G
	0bZC1JyyusDA2z+0XerhElkxk8mBiUk/8HG8OBEPng+q6HkWRSwr4bEKOxoQVChGBrvQQzkxwjz
	yOutENYikeZZHUHo8+JC8yfZiCMb85i9MH++lO2Spf/skulyQ8DTfaljOiLfZ31jaw9/r+rLaa1
	DyXM=
X-Received: by 2002:a05:6000:1889:b0:3eb:c276:a340 with SMTP id ffacd0b85a97d-3ecdf9bebc0mr1073626f8f.5.1758090120713;
        Tue, 16 Sep 2025 23:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH95sM8zcZA3S/ZThSNtLvc2pETLqqWNVH9/PfGgCarDap7/c7q1p/06ACiud6tmXkUphYpCQ==
X-Received: by 2002:a05:6000:1889:b0:3eb:c276:a340 with SMTP id ffacd0b85a97d-3ecdf9bebc0mr1073598f8f.5.1758090120354;
        Tue, 16 Sep 2025 23:22:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecde05551fsm1861195f8f.23.2025.09.16.23.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 23:21:59 -0700 (PDT)
Message-ID: <f6f59318-c462-404b-bf4f-ae121950be8c@redhat.com>
Date: Wed, 17 Sep 2025 08:21:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] PCI: Allow per function PCI slots
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
References: <20250911183307.1910-1-alifm@linux.ibm.com>
 <20250911183307.1910-4-alifm@linux.ibm.com>
 <07205677-09f0-464b-b31c-0fb5493a1d81@redhat.com>
 <e86caff6-8af0-48c9-9058-c1991e23160f@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e86caff6-8af0-48c9-9058-c1991e23160f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Farhan,

> Hi Cedric,
> 
> Thanks for pointing this out. I missed that dev->slot could be NULL and so the per_func_slot check should be done after the check for !dev->slot. I tried this change on top of the patch in an x86_64 VM and was able to boot the VM without the oops.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 70296d3b1cfc..3631f7faa0cf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5061,10 +5061,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
> 
>   static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>   {
> -       if (dev->multifunction && !dev->slot->per_func_slot)
> -               return -ENOTTY;
>          if (dev->subordinate || !dev->slot ||
> -           dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +           dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +           (dev->multifunction && !dev->slot->per_func_slot))
>                  return -ENOTTY;
All good.

I have pushed the Linux branch I use for vfio :
  
    https://github.com/legoater/linux/commits/vfio/

These commits have small changes :

     PCI: Allow per function PCI slots
     vfio-pci/zdev: Add a device feature for error information

Thanks,

C.


