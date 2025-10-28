Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D1307ADA;
	Tue, 28 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670167; cv=fail; b=jO+E05QZH0EhoRszfG0rThRuw4B2051b7Ffvqid0SkWbZIRFAUEGLkgQ9osfAeqf1wiqhzWdo0ve8XmcUSe9L+1FtzICyynXlk0Ef8kwJJkEH7NY2fagASA6LZZOKnTPM8npb6/jxmMxceNV/+vagQVVlYPGppwUAF+fzGR+hfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670167; c=relaxed/simple;
	bh=TsGKha7z5vM9hdDHS958cWylWVpSaNt+fqNC9wZhm/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcBKN8+/rSBqWOZtqAGc+rbB5vFLunrZmOfLHMud+vwPPYpW7CzDsDHfUxdRte0vNbShEcsnfhIBVYN7yp0ylwUQSTJxqBV1FWGJ9WN9SuZ/SCHHELcxnU6D1Gnx5fumOMxA+70+U/PQGbai/BpywlYU7vx4sdXYjblVGNQm5+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XabIZt5T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IsYUhwt7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XabIZt5T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IsYUhwt7"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBDdFX022414;
	Tue, 28 Oct 2025 16:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TlQz5mq6ZQvbvD2JZIaZpNIG+C+C9K19sZu6YhOLkRk=; b=
	XabIZt5TbyZgHpBs7L2aE1ejgMXTOWOo98m/8H7oZLRIsMUCdCN1xCNxEcLQpqdE
	ccj93vwPM/D9NlFRHElZuW2UTpG67Y26kCAuDEsaQYp9VKwBc2FK2bqRdAWqGLY2
	9wG9Bk0Lc2vOarxfoOPllBqUmQ32O7EDzlFPENk4iTrTCt90rB35gDDU/bipmD/p
	098OVNHexQsltzcc4Kq2hrEaOUWVtd7DpeIbCyuw0UcSlwaAEhZM3ZJ299z72KMv
	DfMuNDO41p5u1+/2A3MiIefLwrv6zUjXOpju9cogXtdjvQf36k7O9GaybUctd7pY
	s//+plwL+a/3uTqJ+4tfLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232uv5gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 16:49:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SFcimP034893;
	Tue, 28 Oct 2025 16:49:06 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pfv011-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 16:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTK9jN4y0oEk+FnVme+iwUkh95+ehNWLsEu+KYjnpMQvTMyAVWqib7bq7NYU0ywdEXy95u9d8NFG3p4iUkE3U8JvHRI0IkCrxO3IYacX48eVvczg+2S3vGW6TD++m42+e0aA4pxe9F+N8HngcloL8yaUxPNGjj01UWjPCtK1DHYHNd3XXvXpN4i44BIJ7rKIE6XCC6ePVuG1qLKEyC0jLsLSGjx2kRxonTV8rBzo4MDRSCz5v19mTSMeMp3VOUn4OE5Hb7X4CEoZxJTaaEXLQyd09YYedJ4QxSLMsOrzeDckjZ0V3vaI0/oQwLNf4bsCRCUqsxlW9gOo+oOxR7TkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlQz5mq6ZQvbvD2JZIaZpNIG+C+C9K19sZu6YhOLkRk=;
 b=zGlLumCFnCltJPbmShcTNJ87ArHX/NiP+PX2Y3mLvvH9iQElfo2qA8S4Rn0XDMLDb87kY5DHKqlGz9lpeUuoqcZgehJPj3+XkR0kjMBT/5xq5LF9POoVBxUPbPiZR7quELhQiWcK4nUc0ek9hdQUN6+mrC6v6zeqmThUTI/VGHBkTp8CY+bgNbieMUcwFII5Mjkvrbmaim/N43h1fLDmLMpeFyUqEdXHxRyBhKpbFZ1WHNLUGA6zIe1pgxwVCbbmYkk4ZmIpKohX0lIc3XScl/KOuVrYo4b0Fwk8eXcp7cSI0YB4H4AmUmRMfLpPMtZrD/eLM3Z3ZusIl3qDVZe6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlQz5mq6ZQvbvD2JZIaZpNIG+C+C9K19sZu6YhOLkRk=;
 b=IsYUhwt7ltZ+n1S1P0Qoqq7q8y3IC6tBxF7J6rXVVpGIpp46m6U3m4lWWVPz3JimgkFFpAhGohJOEtiLr/NvWb+FunaiD3lbJVJ2hKiW7h4RcYQhOuLTUg+5+qeQM9mVs7VfDm/+4V9G2kbcN5K/Bl7Q6mAT2hFghdSZZ4G+D/Q=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by IA3PR10MB8757.namprd10.prod.outlook.com
 (2603:10b6:208:57a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:49:03 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 16:49:02 +0000
Message-ID: <5c72e064-9298-490e-b05a-16be6b5590b7@oracle.com>
Date: Tue, 28 Oct 2025 16:48:57 +0000
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, osalvador@suse.de,
        akpm@linux-foundation.org, david@redhat.com, aneesh.kumar@kernel.org,
        borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
 <20251028161426.35377Af6-hca@linux.ibm.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20251028161426.35377Af6-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|IA3PR10MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da4fc7e-43aa-4614-14e6-08de1641e60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T011MWIydVBweG9yQ2lPd0t5OTJtMnkvZmIzTjhlL1Q4QjJsb094V3FkY2Vs?=
 =?utf-8?B?RUx2VnhoMUh1ZGRGVFI1dzRldjkxMU1TWGx3anI3dTg5MXgxODdGWmZsTmFl?=
 =?utf-8?B?bklrYThXM0tZQ2Y1eEd4RFgxMm9MdWVBQkJIcEFGTE1VbmJmbWZDQ2F4RTRU?=
 =?utf-8?B?clZaV0FvNFE5b2tuVGdicGJWZW1QSndpZ3VIamhwUm82dE9DOWZKbmZudEts?=
 =?utf-8?B?QVgxajhrMjF5Z09oQlhTZ2VRMzlPai9nZDR5NWw3TEd3MDk2amJJVzF5Qm5r?=
 =?utf-8?B?YnFZb0pRRnFOdDRwM29NZXNsd1lPR1hKejBqUU5HcVdLWFJzc3YxK1ZPSmRD?=
 =?utf-8?B?Q25oQnFkdzl6Tkt5ZVFOcDE2RlVXVEgyOUUrRm5SYUV5d1VlY3VlTlFIYVov?=
 =?utf-8?B?VWtRcVpibWFBd24zQlRjV1p1cU15c0lEMUd6RnBWNG9vYTJycWFxT3dhMVRw?=
 =?utf-8?B?bitCeEsvQiswOVBTVURaZHFZTS9HZHV0T0w0QndxRlpHaEFVM2F4ZTV1V2Q0?=
 =?utf-8?B?cWRtemtPR2l4SGlKU2xyMmlxR3JxSXVKa0UrZU54d09XUjhXeVd0ZFhrUjB1?=
 =?utf-8?B?elpJN1JXR0NZeEJzVnFNUndzb0lWaFR5bUlxRTZ5bjdmTnA1MUEyZ0xqWE5H?=
 =?utf-8?B?U1FZcGZOUVlraUdTNFZIN0ZxNVhlMDIrRDNvSEhrTWd5RzUveU0wZ1NlNVRo?=
 =?utf-8?B?aXpKZEJ1ZDQzR0YraWpRQS9MQktjemFkVlJBZ3o3N2tjQ3QxOCtuVE8zSmZM?=
 =?utf-8?B?YUU1VUcvQy9GVVY4UUFRT1RDVURWYks4cHo2eHczTmdnRnhDOTB2d2tvQitq?=
 =?utf-8?B?eWxGM3hVYkRIZnlUaThPdjdZMHZGZVRrSk5xSWs5MHNncm5XWmlpUU5YMDla?=
 =?utf-8?B?UjhEbzVxL3JKSXNzbGdMQXgyWnBFOGJJckZoSjl4QjBhQ1NDWit3UTdzbHY3?=
 =?utf-8?B?elh2QmI1NjUxS0o3bTZjbUZURzhCVUNuM3dHb2o0enk4NkNDVHdGTWFaWjNt?=
 =?utf-8?B?R1E5SStqSjRCTWJQUWxKamNVNEx2N0QzMHVTdllUYlJraEYyUUhGUGV5WTNU?=
 =?utf-8?B?N0FwSFg3bHp2cUorY0FBcEQvOEJURHJ6N2ZtT0sxcU9PWUF6ZURnWndQb3BM?=
 =?utf-8?B?d0tXeTFXQndhK1RWcDRxR1krb21ZOEkrbitEM2ptNEZHQ1lxRFlJaDY5SzEz?=
 =?utf-8?B?RlZvVnVsMzhhaVhHSjRQSUdLaWFZMEJadHZ5dEh3WWcrdWNiUnR1V24wTDgw?=
 =?utf-8?B?UnJnOUtwSlljMk1aYnNTckJoeitUcWhOM2tGbWpHdkF3eU5vY1V3eTNTRHgv?=
 =?utf-8?B?SzlCN0tkbW9uQm54T0RoZ3VSWkNNN0lESUpiaGJGZDdSQkhsWEJ1bHRsUXlw?=
 =?utf-8?B?aC9QQkt6amFRNVpyQnFCcjdJZ0JmNlV5cWVQR013Tm9ybUtsTnBzYzZrb2VG?=
 =?utf-8?B?S0VVUHZ6T3NXZ01IeEFOQWxLQjE1bHZ6aGZyeENBTmkybkFVNWN0ZW0ySVdm?=
 =?utf-8?B?TFl0V3Q3YUpuN0NaaldidmJMOE9iek1iYnQ2VVRqWGxDQkswT3hMOWFTNE9o?=
 =?utf-8?B?ajVJZWNIQmljL3hxOUxWSnpqL0hXekd2MHdSeFZoL1pjVGN6ZUFlOTduczd2?=
 =?utf-8?B?Q1JRNnEvK2REeVc5RnNWdCtsTVNUZjAvT3lKMFhlekdMVjR4ejk2ZDQ3Zk4w?=
 =?utf-8?B?V0xCS3lRbkFROXRHVE4zWUlYbXFvMFI2NGc4VVVJRHhZcEhsTjQvRWJ2NzVV?=
 =?utf-8?B?bHg3ZDA3c2hqY2NaVUMyeVpUd2toMVRVYmVtSGw1bmhiN0tzTzlKdVZFTTBV?=
 =?utf-8?B?VUVIVXczcHQybFNaVHVMT2wvdWlDWkdlRlF0SUpuSGRQUStDeTJXbWFBOUJV?=
 =?utf-8?B?MmFzeDZaWmY1ODJ2UGtWeFJnNG5SZjdweWxFbG1uOFJaK0tUcnNoOWFzaXpU?=
 =?utf-8?Q?xTsBIg14WjhupBT1ZqRQ7eDm2uWJsWPo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2lsL3Z0NGxueWd6Q3JNMktidkE3b28wNE8zK3RXYmpUandEVGE2SUk0TkJY?=
 =?utf-8?B?azlXa3h1V0lkWEphL250LzlDSVppYWZuNzB3emFaNFJNbkYzYTluR0lnZ2NQ?=
 =?utf-8?B?bTh6ejFZbjM0VnZvRW8vZ0swNlo0VUsrSWhPOVV3U2JkUVZ2bDRXdEZEbWI1?=
 =?utf-8?B?L3YwMWlQWmpNYUVoNk50cDZBcVlrM0E1VDUyNmlYSmRqWHJqbTJWT2RFRUdq?=
 =?utf-8?B?Qjc3NUtjcjZaVVdHdFJCY1B0WU5RcVNwenB6bi96Y01STmMya2xkWWVoQWNX?=
 =?utf-8?B?NkRZcGVIUzBGVXlvdmQ5bHJHeEpYNzM2Sm5oMmlOUkRER1NjZjg1VWxOSmVY?=
 =?utf-8?B?WVpMd2hJZjNwaFpXMjlITDRWWENwaCt3MFZydXY0UkJmYyt6NnRaakxQaFVC?=
 =?utf-8?B?aGVnSG52Wk5oZXh4UW44b055bUNEZ3c5VWhnMVpQemRDaXJuSU91Rjk2RW5u?=
 =?utf-8?B?TklCNVJMdnN3WkwvSFFqK2NNTFdjN2oyR1NBdW8vKy9vU2xHeGpEQ0oxQVBR?=
 =?utf-8?B?SEZSaGtFa1dsUVJTZUtSVVo2TFpPbmRsTHB2QWNtVHpHS0lrZktneFBtUysr?=
 =?utf-8?B?Q2lXRTRlTDVwZlZzK0hPN2dHRTZLeXhqMGRxSVRZUHRLSjViSmhaM0tRSTBz?=
 =?utf-8?B?VEFMaFZ6cEVkWUtUR1lpVTVYZFpLTHh1QkhZTHE0ejB4VDMwREszelFISE1R?=
 =?utf-8?B?dk9oTEoyenBOenVRRlU5UE05ek5MaUI4Sk9CL29jN2RmZTZtZ2hFYlBHdlo5?=
 =?utf-8?B?d2tmZ1Q0Z2d6azBJd1d6aGtHZ2NQbnJFLy8rY3pGaHo0N29NSnBHdmtWUE9G?=
 =?utf-8?B?aHQxWjhLSHBNV0hmMy9mYjRRakd6K0pLY1I3QU42RXNXMVJEUzhSSDRDWm1X?=
 =?utf-8?B?bU9CWXhCNEN6MjZqQVpiT0RGQ0kvNldibU5nZlJMU2pTN1JFd2ZkbkJZWDF0?=
 =?utf-8?B?anhJdlduSFlUYmQ5QWhXbkh5YlhXVHFVM1dyZmhJRGFYVnNNSDEva2FyaEx5?=
 =?utf-8?B?SmRSeDVmRTZPaGVHM1FFSi9odVVCNFNPYkhaNExSckZLT0hpYkgxL1NvRThz?=
 =?utf-8?B?cjNqck8yOS9TeDFaZCtidXFMOWE2dEthekxvR2Fya1VESStZUm1jaHY1aUpk?=
 =?utf-8?B?SDh3Ui92VlcxZUhvYm9ESDYzbkdicHMzOCtiUmtDamk2QlBieGZMd3RvNFp2?=
 =?utf-8?B?TTNONFlhWXNKRVpPZ3N3L2Frak1WS2xSc3BYQjMzdk9VU2ZkS0ZvRTlzVkYw?=
 =?utf-8?B?U1ZOYlNFTUFXajA1SHI3dW01TzN1am1sMFlZMDFGNTM0M2NOWmRtclNyUHFX?=
 =?utf-8?B?enIxRTJrUnpyUUszNG5sODVoRzFMMm9LT1dvWiszMEJQdnNPTUxocVBWZkZH?=
 =?utf-8?B?OVRrYVg3cVlrcjg3aEZTeHNhUU1qVDk5eWFEbUhHY0dFV0lWWXNnZzlkNjJz?=
 =?utf-8?B?TENPWDQ0TkcwMGlBc3VwNXhZQ2NJelpnZTFUZzJKY0EyM21NV0M2STlybjRx?=
 =?utf-8?B?YmwyQTBrUzRYRHJBUHE1Q2sxelVkbUU3UmswaEZqV25sZGhLTFBwckozeWEx?=
 =?utf-8?B?NVhHN3NaTzROY1lwMXl4a1crWVhGYkNXRHNhZTFPdWVEcnoxaUVaVFM1bFBn?=
 =?utf-8?B?amNWSEpJUmozSldEazFhZ25WenRESG42ei84cGVnaGpneUZjeUp1WXFRWCtm?=
 =?utf-8?B?alFEUFZGRmt0U0tFQVgxU3N2U0RrLzFiZzhJK3A2dWNtOEU2V3lURUt6Wkx2?=
 =?utf-8?B?RWJMOFJqVGJyTkQxZmZvcmZRZUF5T1NQZTQvR0ZEUFFNb2p0VE9BU3VzR3FY?=
 =?utf-8?B?NCtTRWU3OXp1Nzg4SFNodnA0MFpld2Q0RVdoQ0pkcXpXOE9wV2tFaEoyK2Rx?=
 =?utf-8?B?RTdlT2lVVUxKbE5OYlN2aTVTNFErSlNrZGhuVlJrKzZjNTR6dWJKdlgxd3Fq?=
 =?utf-8?B?MkV1YWRvak1WUlBwRlZWb05QSlhuZzhqYjF0MzFIRmpMekFiVWVWWGxWdmFp?=
 =?utf-8?B?MVJOVEt4MTQwWlBCWlQxRnoranZ3MjNBYXJyVlpwRG5jZnF2RVpPcThrQVhJ?=
 =?utf-8?B?WUhIUHZicGNlRzJGN1RKMEQrUkVDeXJHSTJwbTI2NzVBZlBkNklzcURUMVlV?=
 =?utf-8?B?M1dISHI4djlOdmJLeEU5bnRWWEpTM2c5UUtiNEE5alpRa2NRTG4xcW9zS0di?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nRJ4kLwqV4x5Zo5VOO3XpUUQbOhCWctdECW2RUnw2drN8VoTdWbouTXD8aQTfv4rqx7hQv+vMVDU1oNyW5AfZ66Wg8XxBQKmx5r/RbQ/+6V1ROI42+trVv2NoipfwVS/hCVxmvnX6E6JAr2x/kpt5UiIQ6Y/0l/vJ6j3eUlAeN1qMO/GsU88bUrySDuaftdaSj/bTKqo0Z1nE8+ydfx15rsPX+8RQiwHHHVxyPAgRMHdqmcIhj8XnkNDmhSz84wb4QXoJsgWSgU3iAd5N2RAMEzjHJ5VcCtlyL6YrWIAGzBMv37EqXWHUSkqrF4tr2F5To/9Is5QrcxrJCeBrpDyhppwKcAzZ3tR1smMJe07xWz39y3yErCQYW40NQvwyEqeWknYa8levbGBDlwcgLwQP8kUs+uM+M4uw2i++eCxQwaSjz/qQMCttmNkAtPjHuptAsQOktjYkgUyzuft6mzM40stzcJxYtmKHdZ4VwfmoYZi5V2lt1hG8db74GCkkMFUEEKD+hQilizpBAxUPhAfvGBDSx9LOzN97Oci3PJAA3wO2sx8SrQRZL8YQXec+jHREOPYjuow8J8Bb98gBK+Vyngf6HPVDmliXY2FUPfFo8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da4fc7e-43aa-4614-14e6-08de1641e60a
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:49:02.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/ydI98vj5t4oslhShvNQcpxoP1jptkUKWY9m+ECxkQ0DQ30O37cUZT1wdhARb0Tu5ygTwlQv8f/JEl9gi1kMp0io/rTtoTw22wTM0QOsmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=949 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX6T+KOyDGnhWC
 78vsmPYZuca+QPR5hAdW2K/6ZzLgZnngaIxwRCGS3YEyDlbLrpjfaAYdmJ3YfsMCsnVMHMxEoDa
 /3FzF1yMx8FQSnoQTKw3398xB3H4FrLO/qXBC69qUpKJEdQY0NOxL8JpwzszBAMfiYT4YzVWSR1
 P+8Ib8N8615KOoSuV8sEn09zIWl9LagXxKmm7mNYmT7IsrakLfOKNZWihCE6PnKkfRWRJ3wmcB6
 AGB7ZJ5ghk9WHeJ/Kar4f8Ll3OO03FAqFGGl8WoleBrkBWJFKhdttA6gjOnAN3cnTKbsV+xqjEX
 i4DoqIsDcYqKxtuMG8CvhmuFI6OUwf1OhFmzOnIeCfCYeLVWq0kvvNvFq6sV2xJnZeCcIs4LFEo
 yyIaxzzxYH1UsDW0ePowXZw9zvEcnS6EMkRYUBuf9QUVSP9e6EM=
X-Proofpoint-GUID: MpKnKibLWK8AoO3D1AndxqA0lq7rBhA8
X-Proofpoint-ORIG-GUID: MpKnKibLWK8AoO3D1AndxqA0lq7rBhA8
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=6900f406 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jStZf1ixbgci0UuQnccA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12124

On 28/10/2025 16:14, Heiko Carstens wrote:
> On Tue, Oct 28, 2025 at 04:05:45PM +0000, Joao Martins wrote:
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index ba0fb1b6a5a8..5819a3088850 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -48,6 +48,15 @@ struct vmemmap_remap_walk {
>>>  	unsigned long		flags;
>>>  };
>>>  
>>> +static inline void vmemmap_flush_tlb_all(void)
>>> +{
>>> +#ifdef CONFIG_S390
>>> +	__tlb_flush_kernel();
>>> +#else
>>> +	flush_tlb_all();
>>> +#endif
>>> +}
>>> +
>>
>> Wouldn't a better fix be to implement flush_tlb_all() in
>> s390/include/asm/tlbflush.h since that aliases to __tlb_flush_kernel()?
> 
> The question is rather what is flush_tlb_all() supposed to flush? Is
> it supposed to flush only tlb entries corresponding to the kernel
> address space, or should it flush just everything?
> 
The latter i.e. everything

At least as far as I understand

> Within this context it looks like only tlb flushing for the kernel
> address space is required(?)

That's correct. We are changing the vmemmap which is in the kernel address
space, so that's the intent.

flush_tlb_all() however is the *closest* equivalent to this that's behind an
arch generic API i.e. flushing kernel address space on all CPUs TLBs. IIUC, x86
when doing flush_tlb_kernel_range with enough pages it switches to flush_tlb_all
(these days on modern AMDs it's even one instruction solely in the calling CPU).
