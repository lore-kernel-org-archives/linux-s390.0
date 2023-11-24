Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTgvnMJv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C47ED43;
	Fri, 24 Nov 2023 04:16:50 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOBGhDj029458;
	Fri, 24 Nov 2023 12:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x0wjk3MKmZ8cJhls3+GqwgXkgqe2DTRqgyUmRe/fqfg=;
 b=WTgvnMJvgX5GlG0X7GxqOlexpp8UnJ/t53dGprcuMTba3iXwk7yqDHGDndP90DiPAT19
 4kcOOy/pitFejCxPTgZEEMXMp4k+dIEipuEso5MC+C08c6oabe7UcfwKel3oJMUwOzZr
 46YjkgzSH4ZCBdzGYKYWUryShHYGxkn2fAAKB8O+ET8fMPkh6zN5CTDBxMtVXFhnhDEl
 bL/gsaw6mt0v8R/Cl/q12l27TvixFf0aQx8c+9rKeKiSHLXH4gYO1A8n4siPge5nshcX
 E/46g9ApUYi0gF8tGIvMYmfbMjw69gsjdSDT1v1RfUh3jbN7CnqO1YPgGlw3wV2edXTy Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujtm11ktd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 12:16:38 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOBGkYo030326;
	Fri, 24 Nov 2023 12:16:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujtm11kt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 12:16:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOC4Kv2031812;
	Fri, 24 Nov 2023 12:16:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kpdfy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 12:16:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOCGZv128508704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 12:16:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A43920043;
	Fri, 24 Nov 2023 12:16:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C11020040;
	Fri, 24 Nov 2023 12:16:35 +0000 (GMT)
Received: from [9.171.54.2] (unknown [9.171.54.2])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Nov 2023 12:16:35 +0000 (GMT)
Message-ID: <7aca0393-0369-4d03-bbb7-074c9e5ec1d3@linux.ibm.com>
Date: Fri, 24 Nov 2023 13:16:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net/smc: remove unneeded atomic operations in
 smc_tx_sndbuf_nonempty
To: Li RongQing <lirongqing@baidu.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, dust.li@linux.alibaba.com
References: <20231123014537.9786-1-lirongqing@baidu.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231123014537.9786-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BJ85FzkyB7560sVriFkrtmgNf1InTYIf
X-Proofpoint-ORIG-GUID: CEDOgAARI7unDWRci_6GSWJnGBpHGNn1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxlogscore=912
 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240095



On 23.11.23 02:45, Li RongQing wrote:
> The commit dcd2cf5f2fc0 ("net/smc: add autocorking support") adds an
> atomic variable tx_pushing in smc_connection to make sure only one can
> send to let it cork more and save CDC slot. since smc_tx_pending can be
> called in the soft IRQ without checking sock_owned_by_user() at that
> time, which would cause a race condition because bh_lock_sock() did
> not honor sock_lock()
> 
> After commit 6b88af839d20 ("net/smc: don't send in the BH context if
> sock_owned_by_user"), the transmission is deferred to when sock_lock()
> is held by the user. Therefore, we no longer need tx_pending to hold
> message.
> 
> So remove atomic variable tx_pushing and its operation, and
> smc_tx_sndbuf_nonempty becomes a wrapper of __smc_tx_sndbuf_nonempty,
> so rename __smc_tx_sndbuf_nonempty back to smc_tx_sndbuf_nonempty
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

Looks good to me.
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

However I think this time you did not use scripts/get_maintainer.pl [1]
to determine the correct recipient list for this email.

[1] https://www.kernel.org/doc/html/v6.3/process/submitting-patches.html#submittingpatches
