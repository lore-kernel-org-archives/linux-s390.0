Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA659410D30;
	Wed, 29 Apr 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482174; cv=none; b=nRAdqVQZRPPrc/e4mh8jKpPDvCgsz2n+0Tbax53a75jx19hkauu0/Ok5MNk4r+2capOLDoLu2G2s0iu72WevtpLIkKHd6S9cxgOmQBsWJKVYhlegiGDWNv8693erwIptWt9Pn20z92Kp0iYL9IZNcKcqC4t424cRBaZudQOBzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482174; c=relaxed/simple;
	bh=AvSi77U2xdiuDSmJ/4Mmu/UUV3LdEsb/UgY3ImgkueM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmzNMqFGbYstFw4C6cMIf40LELS5/oL30y+vT25lO2Z8XWbB3Saym7OwoGfYT20OV4WOMQJSrESpPjbv1c+aVHP3+9O5x5SQz630iln0W3ItvrN2AyOM9Bvu8TFEa96UQFCazm56Lw0qMfIL9adOMdFQzFDNkQgWDiLJHZ8QhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qDk62q3e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qDk62q3e"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TAOf1L2902222;
	Wed, 29 Apr 2026 17:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZrZvCc
	Ul/7rztmkAGjbnAqrOnzV1q/9Dp6/4+89pYqs=; b=qDk62q3enJfoOr+IZUdAE4
	7TvSpweMA5tt95RhdSUEIQbZLhjcs2VbJp66MDjI9uYwp5SJ7xDdeH26IW/DPFA+
	R2sjiy3Am4R7Gwu7DN86FDkP4psIwXnscpQk8em1u/EHbtWMh6b+VrmFtT4/8+OY
	SKceErdoc5k6To00YVUNI7Nf1rcMsbTTYVxL9u/qnXgN4JY0Ohcq6no7fBFQZSGs
	JV+DPXIoC+2z42NyyA8Jy1IQLWk3QMnymV0TJaGouwLVO4b4cKaW0yjJS140eOre
	+K5GoI0HsCyUsgXGCO24FpeoVTf8b02AfGxRUcpQt52e3gVEG1Vb47gQYyN29/dQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rbn0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:02:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TGrvFn007088;
	Wed, 29 Apr 2026 17:02:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk77mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:02:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TH2iSq32113272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:02:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C0E58071;
	Wed, 29 Apr 2026 17:02:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96FF75806B;
	Wed, 29 Apr 2026 17:02:43 +0000 (GMT)
Received: from [9.61.245.137] (unknown [9.61.245.137])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 17:02:43 +0000 (GMT)
Message-ID: <bd33cf8e-a964-4192-bcb5-90831fa0dba2@linux.ibm.com>
Date: Wed, 29 Apr 2026 10:02:43 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/7] Error recovery for vfio-pci devices on s390x
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
        clg@redhat.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260428220104.GA258993@bhelgaas>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260428220104.GA258993@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KR9ZTGS9C0aErvqqfapBwYpyCMyhf8zl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2OSBTYWx0ZWRfX3xGw8x2vYHVM
 kja3bCTDR5lDIlBsMqy3PxL7rG4lHPMBifEAWA4/fWjFlMEAi3f3evPk1XOpnBaTB3Jbx2VmCbT
 cs0L57pd1M6DV2Rhoum2IbKPvg1V4nGL7JQDz4ksTLiXAEynXO2ri3UtPbRh/yB3N7mohtdRd7o
 AI/afU7JNr3Ez0cqXpfesy84RpyvkuJJpKwql44LI9n8y0T0MvE6BCo5R0tll+7BacqSp+ewxw6
 iB5hfNtLv7dwEjszIH/5//kkhNSUVbEzY/j1Bm/T0NqVwEZ7lbx5hvKu+8ZoeY9drdMGc7lQ1xv
 7RvwGz5O43TGJSDCIl58nY7SbYevl5XUOMXRDw4By6qBbbo6+C+zDGFCWlJgKjy+tn0Ay5pmJja
 PYD3MdGPqdcQDmiVRVW/fuSdDWVIfmUJdiSkwpX1UFl0QzNGoKjOHP3grqUwmtDxAmWvdXue4C8
 RStRnZGPXu7sSYO0Zsg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f239b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=30HAmgh_zRYVhuhcYW4A:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: KR9ZTGS9C0aErvqqfapBwYpyCMyhf8zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290169


On 4/28/2026 3:01 PM, Bjorn Helgaas wrote:
> On Tue, Apr 21, 2026 at 09:30:24AM -0700, Farhan Ali wrote:
>> Hi,
>>
>> This Linux kernel patch series introduces support for error recovery for
>> passthrough PCI devices on System Z (s390x).
> Can you take a look through
> https://sashiko.dev/#/patchset/20260421163031.704-1-alifm%40linux.ibm.com
> and see if there's anything worth changing?

Hi Bjorn,

AFAICT Sashiko correctly identified one error that needs to be fixed. I 
think there were some other suggestions that would require some changes 
based on discussion with Niklas. I will wait a bit more to see if there 
is any other feedback before sending a new revision.

Thanks

Farhan


