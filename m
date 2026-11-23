Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451514;
	b=i5xnYlA77lU+LeizAfI3YEx+9vTZWEsiWXxvIv9hwVH2ASZ/UPXs8oCoyOCxRl1KsbTE
	 ygauFNfQichPfwJNF7NSngNiWspEcSSoSocXibEUh/BIXZx1RQ4uEt5F4iskVIRQorCBK
	 fEsyxmIdQn4+zgDBvrO/b02gXI0CD6SExhYacIv/Lu6amIbXODtRzpOfj5AstOZZ8t8fV
	 1raBJhOYWAPdFVFg2pmxWr9c3/++SEFjMBpygUNqYzXgeDgFlF22MMwMLQ9oDR8ECL86K
	 ruU3c4IQlzJ4sRWsTcMokxFMQwQkmcMcys8NL/yCji9ihrE5dE4AOc6hX7zE/yP+6lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451514;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pUvB2kRIxqQfropPqUVs/0YdeiD9dBNb6ZSxBKngREs=;
	b=Jx8OKWEcuQM20Skh7BI4lwLh1ZI5CgiKX7LXtSMiNf9kkh/al8Jdt246xehKXoa6M9Ac
	 m8Qll+nKVVxFk6y4SymvKWsjEIK+7ksU0oNAsAgg/gIk7SnGfP0+TJ2UE9lX1b7Nx8qm2
	 Jt+7G4Fs99e8G7IixAegKb1+7B0JBR2jiikLt+pa5cX8fNethwly2yIiKRL7m/3/jaQgT
	 KwWWelrmVoqTPkT5CRbUX+RUGRmm/oc4fhZ2++BHvcJKwi5zghg1fymcPgurVWwivFFtB
	 g8zFm+mvVT6JgulhYN1wIepFWPFo/GISbjCGI1pQaDCyUAckXqOTWcGVAkwAoyMfLsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jr5SsTQn;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3B606A321;
	Mon, 23 Nov 2026 16:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F3B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jr5SsTQn
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYreV3696193;
	Mon, 23 Nov 2026 16:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pUvB2k
	RIxqQfropPqUVs/0YdeiD9dBNb6ZSxBKngREs=; b=Jr5SsTQnOTumzUoPFTm24N
	ADgyFOItnfaj+XqWSKwBF+bUoaZkgLoA3ROvGBJfbnxjcRiWAp5k3yZxAzdxmbLO
	aEcpV3N4aax66RJyHZV6n7vBfZWzirESB3Yj812abayUSrjES83wrMs86gvimyfr
	3KeBSH37qTGJpRW6W/foaUCCEY2zZ7ISI0KrYdt7K+h2aSHfZry8eUt2D1Y1o7MK
	rECSZ9e1EOoEcFhYE7HECgNH4ZB4LgPvhHF2lGqPLa3sz5UfqDic89QHBWc+GhHj
	+NtLj2x91bNtXv70CAoIifD/M9kMDXvdeO9cH9EWirO9VTz+iTuzm4LKQo/1KY6g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv3smt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 16:31:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGJmHM3225410;
	Mon, 23 Nov 2026 16:31:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h7ds3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 16:31:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANGVhb552363708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 16:31:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381CE2004E;
	Mon, 23 Nov 2026 16:31:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC74A2004D;
	Mon, 23 Nov 2026 16:31:42 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 16:31:42 +0000 (GMT)
Message-ID: <7008c5ea-58fd-4452-a70a-2162cc3d562b@linux.ibm.com>
Date: Mon, 23 Nov 2026 17:31:42 +0100
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
        Harald Freudenberger <freude@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <a53e12ad841fb18e45b3cf7a4580846943ed0c6d.1795171088.git.u.kleine-koenig@baylibre.com>
 <8548e9504ec70bec02c6f2cebf69ea91@linux.ibm.com> <awBSb7VOGyCCBDv2@monoceros>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <awBSb7VOGyCCBDv2@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b046a74 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=r1p2_3pzAAAA:8
 a=IpJZQVW2AAAA:8 a=VnNF1IyMAAAA:8 a=2ILHlTce9hrp_K-ji3IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=r_pkcD-q9-ctt7trBg_g:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX5JPz5f30adXX
 +67q5Dttbu5BjIrk7Mfxt1ma82ZNlJrSzupNj+8RW67MtbXN79+4GWLDQO+W3Tduywgebakjmbp
 u0yKcDP5TeWtK+0FCCSXsFDi6eWZecg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX5N800XG1mbA0
 K8gXTrn1BRpo4BpBRwB9zCV8oumSxvZYR8a0eSvWvXBEEjDViet/YuZs2zxuYj36+MPLwZz+IIF
 ljFAGJCEowQ0YnNGgFD6a7jhvejqO7jz534FhCUjN74njOaCFC3Q2XRuaapEG0Z084yKNzho12z
 L51c5m4Xx/t4MZON52PJHMiBt62jN6zTTrtDVTT4D2M3s25Gu3D3ami+p4J4MD/gXroyYuWoQOT
 X62FAuxb9/47fDWiZ+qA59c8xj2jRPZA8Ui5lRbWSzpB/+TxlWjSry0run8SBLGGpmLnHHbGoJu
 eOnBqkoTA/a/zaXkfpj4kW9CUF5yxCPFROnKlDbubKrzqXUXPdVg32ffu9JcL60PAktMLeoc37d
 HnVrJLkH6zbG1ZTtK0czgWuugyd+k8LhCzwjDGiKtAieM+AaQG6/dH6ICeq7VPjKC1N0svP7Lww
 KPhXWOplIuTgBb17mfQ==
X-Proofpoint-ORIG-GUID: 8-j7-TolVmhWEFSszm-wIlfkPAVC8scA
X-Proofpoint-GUID: 8-j7-TolVmhWEFSszm-wIlfkPAVC8scA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230064

Am 20.11.26 um 15:05 schrieb Uwe Kleine-König:
> On Fri, Nov 20, 2026 at 12:58:52PM +0100, Harald Freudenberger wrote:
>> On 2026-11-20 12:11, Uwe Kleine-König wrote:
>>> From: Alex Williamson <alex@shazbot.org>
>>>
>>> The vfio_ap and vfio_ccw drivers bind devices through driver_override.
>>> With the introduction of the support_driver_override flag in the core
>>> driver struct, it's now required for drivers to declare themselves as
>>> driver_override compatible, otherwise driver_override bindings will be
>>> denied or generate a kernel taint.
>>>
>>> Set the support_driver_override flag on the vfio_ap and vfio_ccw driver
>>> structs.
>>>
>>> Signed-off-by: Alex Williamson <alex@shazbot.org>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>>> ---
>>>   drivers/s390/cio/vfio_ccw_drv.c   | 1 +
>>>   drivers/s390/crypto/vfio_ap_drv.c | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c
>>> b/drivers/s390/cio/vfio_ccw_drv.c
>>> index 7546bd137e4e..77765cde87f7 100644
>>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>>> @@ -375,6 +375,7 @@ static struct css_driver vfio_ccw_sch_driver = {
>>>   	.drv = {
>>>   		.name = "vfio_ccw",
>>>   		.owner = THIS_MODULE,
>>> +		.support_driver_override = true,
>>>   	},
>>>   	.subchannel_type = vfio_ccw_sch_ids,
>>>   	.irq = vfio_ccw_sch_irq,
>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c
>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>> index 8e69ed286bb9..2d47dc643269 100644
>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>> @@ -62,6 +62,7 @@ static struct ap_driver vfio_ap_drv = {
>>>   	.on_config_changed = vfio_ap_on_cfg_changed,
>>>   	.on_scan_complete = vfio_ap_on_scan_complete,
>>>   	.ids = ap_queue_ids,
>>> +	.driver.support_driver_override = true,
>>>   };
>>>
>>>   static void vfio_ap_matrix_dev_release(struct device *dev)
>>
>> Hm, honestly I don' get this...
>> The driver_override is a bus thing. So the AP bus has support for
>> driver_override.
> 
> Yes, and ap_device_probe() calls device_match_driver_override() which
> requires .driver.support_driver_override to be true to make the override
> work.
> 
>> The sysfs functions are in drivers/s390/crypto/ap_queue.c. There exist
>> currently
>> two drivers which shall be bound to an AP queue: vfio_ap and the default
>> driver
>> which is the zcrypt driver "cex4queue". It sounds like the driver needs the
>> tagging about driver_override support and then similar to the vfio_ap_drv.c
>> the static struct ap_driver initialization may also need a
>> .driver.support_driver_override = true line.
> 
> Can you please talk in form of a patch? I have difficulties following
> your words. (Hint: "the driver" is ambigous if you just talked about two
> different ones. Also what is "the static struct ap_driver
> initialization"?)
> 
> Alternatively something like: "I tested you changes and the xyz driver
> fails to bind, this is the respective kernel output: ..." would be
> welcome, too.
So let me try to translate
On s390, driver_override is how a device moves
between the host and a guest, in both directions:

   driverctl -b css set-override 0.0.0004 vfio_ccw        # to the guest
   driverctl -b css set-override 0.0.0004 io_subchannel   # back to the host

   driverctl -b ap set-override 17.0005 vfio_ap           # to the guest
   driverctl -b ap set-override 17.0005 cex4queue         # back to the host

Your series keeps the first direction working but breaks the second
one, because io_subchannel_driver and zcrypt_cex4_queue_driver do not
set support_driver_override. On the AP bus this is unwanted:
driver_override and apmask/aqmask are mutually exclusive
(46030379f13c "s390/ap: Restrict driver_override versus apmask and
aqmask use"), so once overrides are in use there is no other way to
assign a queue to zcrypt.

We want to keep the way back working, and there is no reason not to.
The problem patch 1 addresses, i.e. a driver being forced onto a
device it was never written for, cannot happen on these two buses:

- css_bus_match() still requires the driver's subchannel_type to match
   after the override matched. This was a deliberate design decision
   when driver_override was added for css (ebc3d17915034 "s390/cio:
   introduce driver_override on the css bus": "unlike pci we still
   require a driver override to match the subchannel type")

- ap_bus_match() always does the device type match. driver_override
   only decides in ap_device_probe() which of the matching drivers
   gets the queue, and the AP bus handles an override to the default
   driver explicitly (ap_owned_by_def_drv()).

So on css and AP, driver_override never force binds anything. It only
selects between drivers that already match the device, and
io_subchannel and cex4queue are the regular drivers for exactly these
devices. They are unbound and rebound every time a device moves to
vfio and back.

I am not aware of a single bug report caused by driver_override on these
buses, so tainting or denying here would only break working setups
without fixing anything.

As these two are not vfio drivers, this should not be folded into
04/10.

We (s390 team) should probably send two followup patches, simple oneliners

   s390/cio: Allow untainted use of driver_override for io_subchannel
     sets .support_driver_override in io_subchannel_driver.drv
     (drivers/s390/cio/device.c)

   s390/zcrypt: Allow untainted use of driver_override for cex4queue
     sets .driver.support_driver_override in zcrypt_cex4_queue_driver
     (drivers/s390/crypto/zcrypt_cex4.c)


Peter/Vineeth for cio and Harald for zcrypt: could you provide such
changes as additional patches?

Uwe, would you be willing to take those in your series?


With these two patches included, for 04/10:

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

also for merging through driver-core.

Christian

