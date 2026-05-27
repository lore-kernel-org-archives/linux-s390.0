Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022135.outbound.protection.outlook.com [52.101.53.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0273C4574;
	Wed, 27 May 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914294; cv=fail; b=gQ2B1z3nETjf8AYRxJM4os5i67lD9a5LZ57LGLpoqChTEVEN8wBYqKdwXAaDICfKG/22dUlq3XQML+oMOGkRN1liR6WBQvdbIUpUh2cugMD92HdJHnBwWqdvOfkPOuhNuPg2eeI2E429uwjvwz5au+Oql1LY+4WeoxhoNZCl1lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914294; c=relaxed/simple;
	bh=DsgTHUBvRcNPEUuKpVSb3aNESKYx+VkhDSjHsArF6OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gI1bchyF3DtCMgx3q4BFxyJp+qkWOlfMXijuAsV8673VI71AQBlMS1tpAimzAY1zWwjlEpHedqFw26TPS5GlX+2Cu10aL/EFQUPt5g0vrrS9J/We+yWcs7PJPKw9z/tF18rt3beZFiwA8so/ti+200tCbHOpd1PHkwv/VUrNoC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kzeiPviG; arc=fail smtp.client-ip=52.101.53.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kzeiPviG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy6msca9eCJVmrNfnYe4oJm4SB1E40o+YVlYk5Ex6Q0RSSveOIhWhlnon1/GujyCHkwAt7thLhalOw5KsoFB0fJMBOuJAEZwQyX0oKIK7TJNAXO/VMPZsjxvCG+c/+YXEDNuD66/fe45aKnDUkMHqqE9CGvBiztUFQrmTuIp0F73IiH4zgGNQgSpKVwTFg2BpOpnL2QsAbWPeHdWVBE8Mt/QAOa7Bvo22AGlsLLsi8vWde+cPg0mPVRCz7BZSk5dUls6VLZjW2E6+BuZB9Us8FQk75BvH23yaNRqZdQOQeGwYn5VCBRG0jKoCEqB0T1NB42vD/yQNQaE1PQfATXo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IevcDDyujZADLp8PWPqUXiDNKrSCGa9wmX64oKm09Tg=;
 b=KOrTdnqQWWUzECsDeCNE/oUKe/AonSmHGy3JB6aQD08KFvziIwV8uCvlQilta8CThPcoJ5qTj4pxoqZiZdHR6yDhpVX02HpXEdhHo/Ilckc5s3gHeS/V+SQNVy1aHIa8DBubWJ0LFlNnIHtu9CS6/5E1+h8pS1M4w5v6mt4s/oHmMcpBzFF0DBNEzTHVCGxTMJ4L7VpSSW8H8XhTcPJ3yObu4gvs9C+U10xulNwTSiG8LH1kedxK3V3ttjcNaNVGQbDRFMG9uDkt26Z3SOubu/YUsqBOz41f3G7vggw+TSTZq+OA6Jq+/MpRj/dtZ1LDLc1rktrw82Eh8J50wgy1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IevcDDyujZADLp8PWPqUXiDNKrSCGa9wmX64oKm09Tg=;
 b=kzeiPviGjuJYAlh8+d/DbLgng1Jeuu14vn5osZBPmg9srTCXA0Vr465vXo2gHnSyq7q7gyJbErip0M4q0GzHFvXvyrfzPaNydyESsZgryjUzMs7qUJRnTgV/qoVjQXaCKvi4DdH3T8TnG84OLQpxYMg5QxokrzNYw9cTlz66sBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 EAYPR01MB994882.prod.exchangelabs.com (2603:10b6:303:2c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Wed, 27 May 2026 20:38:09 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 20:38:09 +0000
Message-ID: <d362d0cc-cdfc-4916-b779-fba62b3fb38c@os.amperecomputing.com>
Date: Wed, 27 May 2026 13:38:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juergen Christ <jchrist@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
 <20260520233409.0683f595@pumpkin>
 <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
 <20260521103742.9603C8c-hca@linux.ibm.com>
 <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
 <20260522091805.18098A5c-hca@linux.ibm.com>
 <f417b97c-e321-6fe7-3a7b-a3a71b16f27b@gentwo.org>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <f417b97c-e321-6fe7-3a7b-a3a71b16f27b@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|EAYPR01MB994882:EE_
X-MS-Office365-Filtering-Correlation-Id: c77c3757-716e-47f6-f901-08debc2fdceb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|55112099003|4143699003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/3MX4t1cqYwIAd+/KBJAsSmv14nFy9aX4RPlNK/OAlIdOy5DygVIbl4zVEbApjIjW/u1LDnZDVT0GBPczYmgPEuHr7vdFb8T+19E1ldYlBbEsT1X+F3jM/aMxqB4pJevDmCBMNgPPBfXTaYqJdwwhKge2ugSQfpxj9Rsu4Cm1+Zq51FCgFNYaZifrzjET+S0r9trohFC7bNePCEB59jDkEadzAIDMOllxZyVW8b0ZT3K1LlgAbiujchpFKvve3PB1Y/KPrsIk2RjKF4i34nhLPt14yZt4ANpuIYV//i+1NeW4Nq/DczUS/5yGsFSulpj/xfT0FJVw96z7ZxS4SeTazbJzHqBpPa2fAaPkEu1LXiy8OqqngUO4CJX0Cyoto1QvYk6iBcq1ULIJhlKLyWorBg6WVZawwa+dLSR8boJvOEzpneBH1uVgEuLTZ9HkSEAUdhTOp55zLSDZmFY5gn4gklfq3SW9F1OwKCk0EJ13M1NsM+kHjN+IwG0NEgVGCPFyvi0aiKUyYsJL5FmF7WzOsL/3Hkav+y8/RDKAmEFlEZ16SQCUeD9N/90O3hLwzK0nlG+5sXJkhvwcdqH564aKAV4siCFW04o+X+NLyCnhg945ymxMQET1xjNkd4o/4gWWjqMMmnsQOU9vGa4+SnsgUy3rcgdHIRfKd6x9XitQFMQ263qo+tjHZpqn2itCUGr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(55112099003)(4143699003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2w5YUJwWHdTa2xVekJIMkIreEYvVTl3WVYrSGNVSTB2Y1RQZDZkelhYbjVr?=
 =?utf-8?B?R25Za1FWOE9VT0lNT01XRkdKMGIrREw4NlczOG5EQ2JtYWpCVEEvL0llbXIy?=
 =?utf-8?B?N3d5UU1ic0FWRnpFcS92M0hSalFZZEN4TWFHN05ZeXBGaTZlVzRIWDRDNnhN?=
 =?utf-8?B?WnpPaFd4bDdIUEhDcmxzTWE5NVlqaERMNDgwN0lPVzVkYnhsUFBqak1KclV6?=
 =?utf-8?B?bTFvL1lKbGVMcU9rU2dVNVEvL2FUNjZ1SGlFckpiUkE1WXpROUhMQkNveTlW?=
 =?utf-8?B?bDIwN3plWUluRHFITksrbURFaWxNc1M0bEdkaVBuZ3VRd3hGd0JtRVFiYkh5?=
 =?utf-8?B?cGpBZXJPV1ovOE5tL0VoVDJ3UEhJTzdQZ3Vlb1c1M3llTzR1a2QyS3hIK3ZE?=
 =?utf-8?B?MFlMaitMemE2V2dyemw0dTFpenFhNTh0ZW9nbWlHUE1GNG80NmtmakJtc2FJ?=
 =?utf-8?B?clV6alR4Ry9DL3B3QzFBb1Q0SDRiRTJLckkyMW1rVlNyU3BqZ2VuUGhUUUxE?=
 =?utf-8?B?UjEvSkUrZjNmeHpxTWtWL1VIK3kzczQ5dlUwSEtFOW5ScjFVSTNQVDQrdzg3?=
 =?utf-8?B?NUN1TzliSUJNWVRVU1BmV1NES0d5TXJKckRMeDlOdEJjMU14eG5wK1BTSmd3?=
 =?utf-8?B?RFQxQkpiQlFpdU9TbjBvbkZ1MnloekZZa2VvalpOY085cE9uaWFVUVFKK2t4?=
 =?utf-8?B?RHlLT0NHSG13NlprWDczS1VSME92Q1g5VTRoNVZOck5EY3oxdmFTUkF0OFlk?=
 =?utf-8?B?bkt4all4WXNML2U5TUtuVEZxVWtId1JvSTNLcFRwVXhPeWlqWEcvMHhqbEE4?=
 =?utf-8?B?UEF2MHRCWUhYR0pvcVBGa2NCZFpLdGJ1RFZYSTlYV3h0VDkwM3ViRVJNQVo0?=
 =?utf-8?B?UFFUWHZhaVRWcHlKV3JxbXNJdjg0QWlSR0N2ejVuNXFLRnNjeEh3dURUSlFm?=
 =?utf-8?B?NVZROVVCRi96b0VoTGJkYUNBdkRZbjlTWFdibWE3YWtJY1paUTZ1SktLSnZy?=
 =?utf-8?B?bHYyYlFJRTE1dTQrTnZ0NGdJb2JMZ0JONjRlc1lINWtlU2pYNXVZN0lzQUly?=
 =?utf-8?B?WE00bkJ3Z3l0MXo1T08yK2pUdmtYSlhSQmd2NU1yekx3UnBSNG5Zd0RlVVp5?=
 =?utf-8?B?NUM1NE5ZQ0tsa0hIZnNCV2tXWW1mc1AzcGJ0QVVGUFBXK3BEYkMvL3k4TjdO?=
 =?utf-8?B?bzdZaTZRZW9uQ0IrWXJIZWIrcjNXdGZGcTJaZ3ZZODZvanJ0U3FsdzVoYVQ0?=
 =?utf-8?B?bmxjdis1WmxiN1lDZVIvVXRKYVBCSHVLZFlwQ1dycHBrK3JDdHVXWDB6T3Uv?=
 =?utf-8?B?UkZGRmcvS3YwVVVqY3JrZ1VOdXA4cVB5REdjZ2QyaUpQa2tXdnZ3UERGWktv?=
 =?utf-8?B?ZkRQY2FXMEg2SVRJamNibGpGMzVjTlRDK01OUCt6SmZ6WlBDWUlRQVQvVTV1?=
 =?utf-8?B?MEZvNm9ZQUIyMkdmWk9aM21rcURXZVk4YlhEdWZHYmxSY2V3NU5oQmNkenBr?=
 =?utf-8?B?UllXampSeVJLeE1RN0lUU3RiVFpndDRMLy9wTFZRMWpYOXdXbjJTb1VFVGtJ?=
 =?utf-8?B?MlY3RUJVaVJmMmpiQkl6ZndlU1dMb0hRb3BrTVdISWIzNlBpUEhIbXdOZ3l0?=
 =?utf-8?B?TFZpRlRXcDg4c0xESEU2WlFaUDZiTFRZMUxNV2lxbm9pY25xUDl6Q3hDTlFE?=
 =?utf-8?B?TTJTOUkyZ1N3TU9qZ3dOSTc5UC8rbDVGdk5WVWtscldDVlhaeEpMRUxSenFl?=
 =?utf-8?B?d1h6cUVXMVlFMzVabXBZcW9GRUJOVG1LM1pLVkJjeE5lNlZOMTJDYnQvaVNI?=
 =?utf-8?B?cE91QVhoenppK1Q3SEt6TkVOb01SS25nVzJTN3gxRUsyWHF2VCsxbjFwQ1BX?=
 =?utf-8?B?emxTQkR3TFhxS0hCZDU5V1FmeEVJVnlPUjUxekxia2dFYk1sNmFRNTJwYmlj?=
 =?utf-8?B?QzJxbjBCVlVLY0JWOXU2eVRsNksxUXg5LysrVjhtOEt6Ty96RUVUYnl2MURZ?=
 =?utf-8?B?TTlSZ0xPdUhNc2FVQ1NXT2NsTXpOTzhJT2w2TDhaVHBPTHI5OGdKc21aZ3I3?=
 =?utf-8?B?dDJ1NlgxekdLUU5qS29lZ1k3ekVSUXc1YzJZTlRZOWF3dy9iZ3B1ZWp6Q2NU?=
 =?utf-8?B?M0R2cmVpWFNiVU1OSWVadGpkMk90cW15aFBVUWFSWDRRMDJHblN3YU53K2JN?=
 =?utf-8?B?MEFONVY0MWJLRzNPa1cxTlZSd0dWREtRSkRjakJRRlhyWThJblUyRkcrUVpo?=
 =?utf-8?B?eGZZWGx2Wm1FbVpvL0dxUUQzU1UwLzNYbVpoYisvczBXOTl0eVVQYk0rbHBV?=
 =?utf-8?B?dmxuRHh0NG9SMWUzT0RZQjkyUk9UOVVlYTlTRXJyRlZVaEJycGZMYUtVUEdH?=
 =?utf-8?Q?jxR64GdL9Jqv2oY0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77c3757-716e-47f6-f901-08debc2fdceb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:38:09.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osMY2zTscVzK+gVez/PEIoyJJqxwRPSsiDvp+9dmlgUhbeGhEBdTMFe3QsJ5+8QOMFYHR/Gn/F+kST64lSMdriJ4RZh77xP50lPNI//VtjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR01MB994882



On 5/27/26 12:09 PM, Christoph Lameter (Ampere) wrote:
> On Fri, 22 May 2026, Heiko Carstens wrote:
>
>> Also with the current proposal I only did some quick micro benchmarks,
>> which resulted in 0-1% improvement, which is in the expected range.
>>
>> It is amazing to see the performance improvements you see on arm64, however
>> I believe that is mainly because of the large amount of code which is
>> generated by the arm64 implementations of the preempt primitives
>> __preempt_count_add() and __preempt_count_dec_and_test().
> The code is generated if you have no arch specific per cpu mechanism and
> preemption must be supported. We have now the situation that we cannot
> switch off preemption support anymore.
>
> It seem that S390 has this mechanism in a small way and therefore can
> avoid the preempt enable/disable.
>
> It is not the quantity of code here. The preempt enable/disable can only
> be avoided if there is a single instruction doing the per cpu operation. A
> single instruction cannot be interupted and therefore is preemption safe.
>
>
>> That's a big difference to s390: for both primitives the result is a single
>> instruction.
> Ok then you can already use single instructions like x86 and will not have
> preempt enable/disable overhead.

I don't think S390 can do it in one single instruction. IIUC, Heiko 
means preempt_enable/disable is a single instruction on s390, but it is 
RMW on ARM64 (3 instructions for each).

Thanks,
Yang

>
> I am not sure what David Laight's code is supposed to do. Seems weird to
> me.
>

