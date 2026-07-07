Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF023290DE
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432963; cv=none; b=neh2IacbKbCmQFs/WmStlSNCNQtw4ZSrIvqOSFm7/Iueu0ihqmmVL+XV1em8D8TEvUcESxeHWXquIDXDsUN0sBkTf1EbvYKjU8qb1e2NWDXFIIaKNmV2QPxFIu2C2N4449vMVje8x52ivNyCRyDRSUuNcvQV21LfCJbRsu+tQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432963; c=relaxed/simple;
	bh=IgQw4df1K5m3Qp14VfFNFHRLjPK3N4eg82PHi2dNl8I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iDZmy620leu5S+n6g3UQewMnNu6wEvr5l/Gawipy4yGmT6eo6aUf5kiT0ZgScro7252zVMGFEdKAmU1M0d6Z3lmNA7ehX33Mwwny3G+7aOPg05o1FIIojxUm/8X7rRxFexTYWTPiBBRlGcTypXfO1zW3r2GEs9xIExcw/T6Ssyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ROwaw4zU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ROwaw4zU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667CIUwO3921836;
	Tue, 7 Jul 2026 14:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=dwo4YqOO/9R0q9UD/FQUfOKVFEO2JtvG7o6MI3Wirto=; b=ROwaw4zUOQBi
	z71qqViqPJOflG+8fwdt+7RDU/nhzWWe/wuaFZt2Ana1sVyViKiV5noZpEUZUNYi
	yf7wWcZLTLRwZRHydJeYGDRfjiMkqC9ly1KllVoZ0jNUYGtaXKJPslP8n9r+ZgsP
	Svu2y43DCX9/740qQMo4WYHCEaLoL00AozfebYKmd1Xhw1sAsU/x5j/eIz+cdFoV
	Ip1NTiZ51TyN/AiOxS9vFVOATVLG/R4MiGI4iaiFrmZD2VO161XvV708dczeuxq2
	bmclDiD1ndPw1k1XRT8k8zo/+QSLAXMqeuLcyShTsFLBN6Q32cXq+w+/dDcG3emN
	zb8wLrdAcA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknfc42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:02:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Dnca1001904;
	Tue, 7 Jul 2026 14:02:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq3amc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:02:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667E2T3128181116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 14:02:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28B6458064;
	Tue,  7 Jul 2026 14:02:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BBB658052;
	Tue,  7 Jul 2026 14:02:28 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 14:02:28 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jul 2026 16:02:28 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com
Subject: Re: [PATCH v10 00/21] target/s390x: Extend qemu CPACF support
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <87jyr7jg13.fsf@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <87jyr7jg13.fsf@redhat.com>
Message-ID: <f5da328519f83191277bd5b3d8060712@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4d06f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=C6PKHtwbsP3GpM_CdIUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 98smh0Zufwe77KJ0jVdBakMm59syhZuc
X-Proofpoint-ORIG-GUID: 98smh0Zufwe77KJ0jVdBakMm59syhZuc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX5w96eI8LQ08M
 NhCRoCPOU4cchuDAzo2XS8hvSY9jbS/X/Lb05LumTgHgQChczHGZ2GpVXMHwQZs5HGIwJwlaVgh
 S7G9ive+XdPO+b2tiOhCVEUEuTOaXsM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX7vB6z/Y2VW1k
 eXbl+WRW5DIkLHUlD0SAR2BBQ9gU6EOzts9+VttnpDwv7CcQnE19ni4wHPE14Bd6b5C5Q3xfXW5
 J3vpdpc0ikm4p89QWaicNAUqERqBJc/GGxN2f/iyYzNTf5OiPlKcWMdN2KTezujvJHmo8McBDn6
 Wnlt3rUkQtwSAGoaF6BCYgXLX2s9TDsbez7yoiYBMMxRGAl/bJNhPnE5NarGkun2zhYkfizuhXP
 K9ENI7Kjjry9SGNHuGHh5WlEdQWaerXqUM7kwTX3xU1Aw0Fil7MZNAAUp319xcbNIYg2+l22k+B
 ZpvBmahvF+j+TZECVLVWQVhWpGhZ4UrQvDUZCGvczqSuCXyE57RKA7EBHzB6AjEh4dgj2dDcQEH
 n1SjE+GP8Kv/o1o+FkcEQ8/xpMdSrQ7zNXqERkxiOZZTXP2l4ft3tGo0EHp6HCTEsvQbHTGF6qs
 HNeZrIyCEMv/F7OQBDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070135

On 2026-07-07 11:38, Cornelia Huck wrote:
> On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> This patch series extends the s390 qemu CPACF support to be able to
>> run a subset of the CPACF instruction cross platform. There have been
>> requests on the kernel crypto mailing list about a way to test
>> s390 specific crypto implementations. For example a way to test
>> s390 CPACF exploitation code like the s390_aes.ko kernel module.
>> 
>> So here now is a set of patches verified on x86 and s390 which
>> over (slow but working) support for a subset of the subfunctions of
>> some of the CPACF instructions.
> 
> Hi,
> 
> I wanted to pick this, but unfortunately, there are some problems with
> it, as spotted by checkpatch (sadly, I did not see this earlier, and
> softfreeze is upon us...)
> 
> - Licensing information: new files (e.g. cpacf.h) must use an SPDX
>   identifier instead of licence boilerplate text - this needs to be 
> fixed
> - some files are using tabs instead of spaces in some places
> - there are also some other moans (less important), but you may want to
>   look at them anyway (the long lines are not really a problem)
> 
> Cornelia

Yes, I saw these checkpatch complains but as nobody else seems to obey
to the checkpatch findings I ignored most of them. However, will fix
the license and tabs things and then let's see what remains.
