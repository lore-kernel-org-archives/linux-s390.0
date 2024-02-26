Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE912C7F0;
	Mon, 26 Feb 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966264; cv=none; b=Pa+fU2j1R4pqZppym6KYbx21aWOjifK6VUGtioEaqyHHisIwFpG76zzxjOtrY6lJRuybbyaAelRlw88DibabXpRWX8Kad0EWEgw6jXbIMi1RnBe2T54uVwQwrWDaxveiqc7iZrUovYa9xrDR767bPa2ZRuktmXe+NrkQ3G1SihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966264; c=relaxed/simple;
	bh=vj6/baR32a6wUJ9g8AiwhPa0mNXLa5H1hrf74PpjHLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvVcIAbYZUY9S4Eg4r+FGAShaIQXM9yVpUWjLfKfOUAjIk+aUhRW5C1oxLVQSKXswcDZ6WXNJteYW/v0eYErHXk0xy1H6+O7+sk5GPBA07C9bDJrNqmI1v8ZY2+R3mIjbkQf9EOlf8VD00lXJUiSIGuOnowv0GM39dI5whhARgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ozZgZwxa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ozZgZwxa"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGSVl0023359;
	Mon, 26 Feb 2024 16:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vj6/baR32a6wUJ9g8AiwhPa0mNXLa5H1hrf74PpjHLg=;
 b=ozZgZwxackcs/u70VFPXADqs72yCeulUhBw7uqby7yzNFloAbH6chum4Gz0q4if4yrOF
 SZe4uDDLYpfLA7D3EasNRWKxhglqk1KjY/B9FkNR/wgkj3/06wz2+SzYQk9YMPY67z1J
 +iXtXb3ek9636aeSe5r2nU7579itVpefmapK9M0iyNuuYkbop4ioBYeVTgOoGsW9Koq4
 a+vKLugszEAPDULuC/N8gTJVQ534DzQVklR18b8mP+q8BIEUAAJdgOJcj1e3lFxRLnok
 ei7okIVRA4BvQYt5+pfpyNh/OM4qrTMphtltEFYYsXQKNDoy5WaNS39rISeZd29rnJUI 5Q== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgx6mgmma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:50:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QFTLLl024122;
	Mon, 26 Feb 2024 16:50:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k230x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:50:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QGosE47668346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 16:50:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B6D458057;
	Mon, 26 Feb 2024 16:50:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE1358062;
	Mon, 26 Feb 2024 16:50:52 +0000 (GMT)
Received: from [9.171.88.168] (unknown [9.171.88.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 16:50:52 +0000 (GMT)
Message-ID: <c438677b-e50c-4649-b7b9-406f64bdf2de@linux.ibm.com>
Date: Mon, 26 Feb 2024 17:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dasd: cleamup dasd_state_basic_to_ready
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240221125438.3609762-1-hch@lst.de>
 <20240221125438.3609762-2-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240221125438.3609762-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZAGyGrIXJks_fANi05DYCKbiNlti_UoT
X-Proofpoint-GUID: ZAGyGrIXJks_fANi05DYCKbiNlti_UoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=704 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260127

Am 21.02.24 um 13:54 schrieb Christoph Hellwig:
> Reflow dasd_state_basic_to_ready a bit to make it easier to modify.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>


