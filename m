Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atZpFcxA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79BA101
	for <linux-s390@vger.kernel.org>; Mon,  4 Dec 2023 08:09:47 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4G2sBf023621;
	Mon, 4 Dec 2023 16:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=N+WPR8+bW5PfUNj0g2dwwavjoBTzOqufRn32S4TwH2A=;
 b=atZpFcxAa5v5Cgn3nWpJiWKRmx/M0awWEo3xUwMS+X9Ap2WBi3uwTzYB0K5kaqip1pZs
 puNPvDouyXd2ARcXyAtzgI2ckiscMYDD2Qijrn6pQ+kWT85jk0k6DOuNNZF1zqSMKgDQ
 uf5mbd4lZ0a1C+glLcJyxIK96LTQk/9Bg7Qd/RCb7ZDpkmCPQOeIxh5tl76wHe/NwW24
 ckQv+ZsReMliGWWKCV7miRZ/BM9uCEFP+YeZpJAFZibipFq1xbcD3+w79PfkDSK1mZOK
 PkKcvILQZDbEHVaiLfo6KZMqk7saZOsC111Foe5b6dCm9MFc4jjmgIgc91FOqu8XRh6Y lQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ushxp09xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 16:09:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EJRQG020507;
	Mon, 4 Dec 2023 16:09:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8dnykt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 16:09:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4G9hVS21037814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 16:09:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BAF58059;
	Mon,  4 Dec 2023 16:09:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3592258043;
	Mon,  4 Dec 2023 16:09:43 +0000 (GMT)
Received: from [9.171.60.183] (unknown [9.171.60.183])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 16:09:43 +0000 (GMT)
Message-ID: <ccc03f00-02ee-4af6-8e57-b6de3bc019be@linux.ibm.com>
Date: Mon, 4 Dec 2023 17:09:42 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SMC-R throughput drops for specific message sizes
Content-Language: en-GB
To: "Nikolaou Alexandros (SO/PAF1-Mb)" <Alexandros.Nikolaou@de.bosch.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
References: <PAWPR10MB72701758A24DD8DF8063BEE6C081A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <PAWPR10MB72701758A24DD8DF8063BEE6C081A@PAWPR10MB7270.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sc42-O2mlfcVOTBLbPG0M5OowmVOvsgW
X-Proofpoint-ORIG-GUID: Sc42-O2mlfcVOTBLbPG0M5OowmVOvsgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040122



On 01.12.23 14:33, Nikolaou Alexandros (SO/PAF1-Mb) wrote:
> Dear SMC Maintainers and Contributors,
>   
> I would like to bring to your attention some observations made during recent experiments conducted with the SMC-R on the following system:
>   
> - SMC version: 3E92E1460DA96BE2B2DDC2F (version 1)
> - Kernel: both v5.4 and v5.15
> - Ubuntu: 20.04
> - Benchmarking tool: ‘qperf’
> - The SMC-R vs TCP/IP throughput has been measured using the ‘qperf’ tool for various message sizes ranging from 0 to 8 MB.
>   
> 
> Based on the attached plot, you may notice that the SMC-R throughput drops substantially according to a periodic regular pattern.
> 
> A few configurations have been checked, but the pattern described above persists:
>   
> - All the min/default/max values of ‘net.ipv4.tcp_rmem’ and ‘net.ipv4.tcp_wmem’ have been utilized.
> - Experiments with the Linux kernel v5.4 and v5.15 have been conducted.
> - The MTU size has been changed from 1500 up to 9000.
> - Several message sizes have been tried.
>   
> I was wondering whether you could help me understand a reason behind these drops, please? This behavior is not observed with the TCP/IP stack. Any insights or guidance would be highly appreciated.
>   
> Thank you very much in advance.
>   
> Mit freundlichen Grüßen / Best regards
> 
> Alexandros Nikolaou
> 
> Bosch Service Solutions Magdeburg GmbH | Otto-von-Guericke-Str. 13 | 39104 Magdeburg | GERMANY | [www.boschservicesolutions.com]www.boschservicesolutions.com
> Alexandros.Nikolaou@de.bosch.com
> 
> Sitz: Magdeburg, Registergericht: Amtsgericht Stendal, HRB 24039
> Geschäftsführung: Robert Mulatz, Daniel Meyer

Hi Nikolaou,

I'd like to help you. However, I need more details on your environment, 
setup, and test scenarios. e.g. which buffersize are you using and on 
which message sizes exactly you got the drops? How many connections you 
are using? etc. If possible, could you show me the output of the qperf 
tests with your commands and the output of following commands:
smcr info
smc_rnics -a
smcr -d stats

Thanks,
Wenjia Zhang
