Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804749;
	b=ylLsK1KRfi9NOpHHcUReXqWrvedRzGwndA+dohSGTUxiwh9/du7qPFU4uBYTXDVMpcuR
	 495rxI5YL/GIUYt8Lc22G9fo7gtTNkGXgKtkApL+szeShQerABXwn9A2VZa/Mz7qEfoMn
	 9LjNGJPa3lHtqY52nMguFSy2g75cwPn+XKqXfjqY+sJ8X10h9XY9DpYDQj2u9DF+kKMRA
	 E5kBHQGHvO7TkGEL+ZB7JauPOKXcRLeSSCnrG64FQlwp3dX81sS4Wm2E1g6Oy1CKXGyRl
	 HhSS/lJBK859o+btn6jLoTWAGK78VGXZo6bYaezQY4EeB5vPrZczXzAszaHLLxgISag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804749;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cxkSymY21rIaHHQKgokU6f2pFt1aFvR5dqO5c8AxGZo=;
	b=mREfnIru2jXbjQpBaqBstLUyOFG+ANv0R5jj7VViV/JkQzoidSg66RUS5GSXSqxzirEe
	 GRp2qFLxWf5brCy8oOTHOlDWMq/YYCLDbvaRG2b35bUaDav0ZXVOYcGlGsbp7JuaGBTTo
	 8W00zRGyuDGfm7Wxo0P/o3gjyCa3QX2Y/NohZD9t+UbGnvwKgZBJdarEF1y/WeUcyKU1s
	 DI7EEA5Cot5dsfKMZxGsI7yDDPihTNj56meeImrqwFkMG0SGXUP5bMwPI6pUsUXHaEFf7
	 B0ojjh8kfShECNHEFAxppikeFk3Mp+VNCuRmKPdBGvr5Io9Bw1M0IAlLXCLgNqbfzqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UHU1IuKh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB1606A31C;
	Fri, 27 Nov 2026 18:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43CB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UHU1IuKh
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARG4tSZ3660308;
	Fri, 27 Nov 2026 18:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cxkSym
	Y21rIaHHQKgokU6f2pFt1aFvR5dqO5c8AxGZo=; b=UHU1IuKhXDIoj3UMu6RrxL
	SlfnZXcf9fnkoiWNAxK8K6LhCdmskqunxaqagxiDiDNk8D97MRW9E3w3cqsCRsP4
	VISzjhK3MG0DnBCS4mmp9sUUDvIPHe/loU0a/+FAyzy3wQnVPhbXkKa3MhYatHeR
	/ORyRZ0jI29rCJwOCMCko8B8NDT7Mf4C/RZcdNHVBpDXNTD58xiqDnQ6fjJdNHpa
	XynEwq5LFVrk9sQPnXQjK3EjP3zWS3fO7AAGUXJFy2jgC+WzIAA5UEVufHyvhRSc
	TtIHI4o/xYdhBVl0K9/tgbnx2OiaFbNWd8Aa5/H0xJl5TmOhxJLS7DBBFEeBRUVA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34faq7u7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 18:39:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARFnMrE3360171;
	Fri, 27 Nov 2026 18:39:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx9ydy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 18:39:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARId1I719006094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 18:39:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EDA058066;
	Fri, 27 Nov 2026 18:39:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84F2958064;
	Fri, 27 Nov 2026 18:38:57 +0000 (GMT)
Received: from [9.111.130.58] (unknown [9.111.130.58])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 18:38:57 +0000 (GMT)
Message-ID: <8213e556-4a5d-46d5-8caa-00384a688145@linux.ibm.com>
Date: Fri, 27 Nov 2026 19:38:56 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] s390/vfio: Allow untainted use of
 driver_override
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
 <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com> <awBSb7VOGyCCBDv2@monoceros>
 <7008c5ea-58fd-4452-a70a-2162cc3d562b@linux.ibm.com>
 <awgBZ4vKmsLzU2qo@monoceros>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <awgBZ4vKmsLzU2qo@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3NCBTYWx0ZWRfX7bL/1ozgeF7u
 GvmYIXWNEEybUnOzM8ToYKrAqdek0DzPhU3vXEsBo1kDN/nnag2Lhl567QNy5ITUjKL5g8Heb/8
 VgjZA8cu72BscX6vw6oOhRK+oNOIrCpW3B3NKCY2bCyFQjrae6wvhsx7ggVGCGCKrYcrmN1GtWt
 XYVZpvSUZkmn+0fI6VKslp0zX9oGOOKsutZogaTvUgfO+1Y/WxeWrTA/j0F0jxUgZ5pQ0jK6HAV
 b1P/JRDaZ51IS2/LFiVb8V3zaJSOuTx11a+ZcqRihkryz7sxT2uG+RaYqZQMU8J7ccaXigfZbqT
 FH7ZgQqYUUG4xLtvQvIXT+ZRXE0whJm3OugQQ+dGdDfQw4gyJOoBzu0ePWD4m5OzRdGEXPQevmS
 DNV/G0swq5BpIsn4e21R2uLhh+5b9VeUsvXKKmfpyaaCUsyvlByjdgDnXDrYnc9L50uniKiFN5T
 SEQECAhRFH95tBbaBcg==
X-Proofpoint-ORIG-GUID: pgIJoTtQAkphfoDCDfbWswBSZF9to_7N
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b09ce47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=UYTh1CXzSR2NwupNoPsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pgIJoTtQAkphfoDCDfbWswBSZF9to_7N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3NCBTYWx0ZWRfX0sR6l0HH1gj6
 sbOmyw28sOuhdVq4gO8Z1rWGDc7KLlg1T3Q2i50GzS3q36ECSNX/P7taFEKf7h6yLfZVvOP+VZB
 33vIptmKorwjX5zz1WhbHlZuojGJNXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270074

On 26.11.2026 11:01, Uwe Kleine-König wrote:
> On Mon, Nov 23, 2026 at 05:31:42PM +0100, Christian Borntraeger wrote:

[...]

>> So let me try to translate
>> On s390, driver_override is how a device moves
>> between the host and a guest, in both directions:
>>
>>   driverctl -b css set-override 0.0.0004 vfio_ccw        # to the guest
>>   driverctl -b css set-override 0.0.0004 io_subchannel   # back to the host
>>
>>   driverctl -b ap set-override 17.0005 vfio_ap           # to the guest
>>   driverctl -b ap set-override 17.0005 cex4queue         # back to the host
>>
>> Your series keeps the first direction working but breaks the second
>> one, because io_subchannel_driver and zcrypt_cex4_queue_driver do not
>> set support_driver_override. On the AP bus this is unwanted:
>> driver_override and apmask/aqmask are mutually exclusive
>> (46030379f13c "s390/ap: Restrict driver_override versus apmask and
>> aqmask use"), so once overrides are in use there is no other way to
>> assign a queue to zcrypt.
>>
>> We want to keep the way back working, and there is no reason not to.
>> The problem patch 1 addresses, i.e. a driver being forced onto a
>> device it was never written for, cannot happen on these two buses:
>>
>> - css_bus_match() still requires the driver's subchannel_type to match
>>   after the override matched. This was a deliberate design decision
>>   when driver_override was added for css (ebc3d17915034 "s390/cio:
>>   introduce driver_override on the css bus": "unlike pci we still
>>   require a driver override to match the subchannel type")
>>
>> - ap_bus_match() always does the device type match. driver_override
>>   only decides in ap_device_probe() which of the matching drivers
>>   gets the queue, and the AP bus handles an override to the default
>>   driver explicitly (ap_owned_by_def_drv()).
>>
>> So on css and AP, driver_override never force binds anything. It only
>> selects between drivers that already match the device, and
>> io_subchannel and cex4queue are the regular drivers for exactly these
>> devices. They are unbound and rebound every time a device moves to
>> vfio and back.
> 
> Ah, understood better now. Feels like a misuse of driver_override to me
> and because the ap_bus's usecase doesn't match the intention of
> driver_override, keeping the bus working is strange as it exposes this
> difference.
> 
> Without having checked all the details, I wonder if something like that
> would be the more robust change then:
> 
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index efd3df3e90ba..2d07bca149cc 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -1398,6 +1398,15 @@ static const struct bus_type css_bus_type = {
>  int css_driver_register(struct css_driver *cdrv)
>  {
>  	cdrv->drv.bus = &css_bus_type;
> +
> +	/*
> +	 * The driver_override mechanism provided via sysfs is used in a
> +	 * non-common way for the AP bus: There might be more than one regular
> +	 * driver per device and using driver_override the right one is
> +	 * selected. Wrong drivers cannot be forced on a devices as the
> +	 * subchannel type still has to match.
> +	 */
> +	cdrv->drv.support_driver_override = true;
>  	return driver_register(&cdrv->drv);
>  }
>  EXPORT_SYMBOL_GPL(css_driver_register);

I consider this approach not preferable since someone who doesn’t know
about the extra logic might get confused why driver_override works
despite a driver not specifying it explicitly.

[...]

>> We (s390 team) should probably send two followup patches, simple oneliners
>>
>>   s390/cio: Allow untainted use of driver_override for io_subchannel
>>     sets .support_driver_override in io_subchannel_driver.drv
>>     (drivers/s390/cio/device.c)
>>
>>   s390/zcrypt: Allow untainted use of driver_override for cex4queue
>>     sets .driver.support_driver_override in zcrypt_cex4_queue_driver
>>     (drivers/s390/crypto/zcrypt_cex4.c)
>>
>>
>> Peter/Vineeth for cio and Harald for zcrypt: could you provide such
>> changes as additional patches?
>>
>> Uwe, would you be willing to take those in your series?
> 
> If you don't like the above change, that would be fine for me.
Here's the patch for the CSS bus:

From ea91296ce7ee0f31aa584736f130a86237f054eb Mon Sep 17 00:00:00 2001
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Thu, 26 Nov 2026 17:27:04 +0100
Subject: [PATCH] s390/cio: Allow untainted use of driver_override

I/O subchannel devices on the CSS bus can be bound to either of two
drivers:

  1. io_subchannel: the default driver
  2. vfio_ccw: used for KVM guest pass-through

Although the CSS bus also hosts devices that are not I/O subchannels,
css_bus_match() ensures that only compatible drivers can be bound, even
when driver_override is used.

A previous change marked vfio_ccw as compatible with driver_override as
part of the logic that disables driver_override by default. This created
an asymmetry between vfio_ccw and io_subchannel: users can switch a
subchannel device from io_subchannel to vfio_ccw, but not back to
io_subchannel.

Restore symmetry by marking io_subchannel as compatible with
driver_override as well.

Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/cio/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 68dd4a62975d..bfb0a18c395a 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -164,6 +164,7 @@ static struct css_driver io_subchannel_driver = {
 	.drv = {
 		.owner = THIS_MODULE,
 		.name = "io_subchannel",
+		.support_driver_override = true,
 	},
 	.subchannel_type = io_subchannel_ids,
 	.irq = io_subchannel_irq,
-- 
2.53.0
