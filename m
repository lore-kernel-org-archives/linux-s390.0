Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E115AC8
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U1ZBYLx8"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BBCI76012684;
	Thu, 11 Jan 2024 12:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yTiXG/Y0RGIbpe92y47RHfw4qcw/AcKNBq7ZybsR5nM=;
 b=U1ZBYLx8/3FEvGEdcKBWrp3Xamm0mzjEBr9FMXjDrhYimesLqAv2J/GoXx6R8Utmo2Yw
 8Y8NNo6ludCrtIuSNYmhmph2E+E/ymzWl9XiOyipdCy3TAsZzbySQrOnUQlNxiw4YBvu
 W0ljXDmahA5ZSwOWuQpdYpKp/670DAOv4HoSMgk/Tbhw9OCgUdlx7NBrljv/Qm/JUSsz
 xot9Xf93QL2TYY6c6GsEhQGK3sdCsbFZIIkFytw2S3tRYVrP50M5niKWG5HNDVGewYTd
 YbVeu93A1L6iOpi5Uz1Mj7hUUkvkt6d3DNPtclKs6f6xJSpJyiUcPgZUrpKf1WTtxIFM 0Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjf8etmww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 12:59:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BAPBpZ028052;
	Thu, 11 Jan 2024 12:56:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vgwfsyf25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 12:56:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BCu17918416292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 12:56:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984F32004E;
	Thu, 11 Jan 2024 12:56:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6222A2004B;
	Thu, 11 Jan 2024 12:56:01 +0000 (GMT)
Received: from [9.171.5.135] (unknown [9.171.5.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 12:56:01 +0000 (GMT)
Message-ID: <a69fb463-384b-4bf1-8cc7-0d442ec72b2c@linux.ibm.com>
Date: Thu, 11 Jan 2024 13:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/dasd: fix double module refcount decrement
To: Miroslav Franc <mfranc@suse.cz>, linux-s390@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>
References: <871qap9nyi.fsf@>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>
In-Reply-To: <871qap9nyi.fsf@>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O1PiBprBRYK3yv2nHZs37PLSgjD3BovV
X-Proofpoint-GUID: O1PiBprBRYK3yv2nHZs37PLSgjD3BovV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_07,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=571 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110103

On 10/01/2024 17:01, Miroslav Franc wrote:
> Once the discipline is associated with the device, deleting the device
> takes care of decrementing the module's refcount.  Doing it manually on
> this error path causes refcount to artificially decrease on each error
> while it should just stay the same.
> 
> Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
> Signed-off-by: Miroslav Franc <mfranc@suse.cz>
> ---
>  drivers/s390/block/dasd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 833cfab7d877..739da1c2b71f 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -3546,8 +3546,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
>  	if (rc) {
>  		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
>  			dev_name(&cdev->dev), discipline->name, rc);
> -		module_put(discipline->owner);
> -		module_put(base_discipline->owner);

Good catch. I think there is one more line above this part that should
also be removed:

if (!try_module_get(discipline->owner)) {
        module_put(base_discipline->owner); <---
        dasd_delete_device(device);
        return -EINVAL;
}

Can you add it to the patch? Thanks!

>  		dasd_delete_device(device);
>  		return rc;
>  	}
> 

