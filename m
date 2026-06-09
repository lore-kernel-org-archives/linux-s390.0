Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022121.outbound.protection.outlook.com [52.101.96.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1214ABE;
	Tue,  9 Jun 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013658; cv=fail; b=d6d8Zqa8blOJQDpuFz9i/JQLgn3MW0I+SPXDBTrcY444MT3suIIAjcPaZOBkeKvCGXKYjCmJbIoylxmvrbblVBds2B8fqITHrnlzq7lMmwhfyyFJXCFQCbb9Eg+5JiIpFeZrZXQoV2p3wMh4YzR/NqQy6rHEc7Zp5rKyckoiaCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013658; c=relaxed/simple;
	bh=gUPAn1RsX9pqaVkv2cX9SVna+2x2IlHyRMmjk8jFHCw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SUe5KBRdMrvcfguOcNM1CyFdGlSEku27Il49GV0WKbzlFRvXqpIjg001TGU6i+zhZWe264v6Ku5eqpAHJybgLYPnqaHXi3maxGZ8Cuho0HdE5liHTC3qM0HJVqMSBVQSiZQ3YqI9gHM/T8Q1CvMRQ/lnzpdH6aL6dcE6X7cXZN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JhpNFnE0; arc=fail smtp.client-ip=52.101.96.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JhpNFnE0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egv3iRHZF2JcPmDrf3HmeRKVfmecwbtZhkhn1J3c2m60cSeTD+iHJVIPtaid8N4cRQ2vrOTFz9jWQIUyppzTJvulcMlhfKupbHTYw20O2BRZxAQFIUQildWQBcOpVp26dDNeJfv4EeT7CI4nZpjfGdYUj4fjJYWFUdi5w1maMWgQdaa+v1Qa7/ZcGMYZSAx0tlJx0LIZfljmj6jxVJNY6jqxhtjQbeHFW6r5QjoqrHj0KnDOvP0xoxJZ/0q2pMtY5OmjfoVJulAf2uYlGcADcoGjaoJqv/lQYKF4LmGsk2TPDSyWq7KUWEYN9KQf/AXQivs9ecbL5rTpqDQ1uVpOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUPAn1RsX9pqaVkv2cX9SVna+2x2IlHyRMmjk8jFHCw=;
 b=Z2KCE9HDY9Sct1/uN/tp2hd1TPUE2WzB5sJWkltt7VcqJrT4ISmAzprHwaIg0c21+y16IUAdyK38cvSu2rn6vj8/dHUtPqwS4xNVE/Whoqi/ERMoNhULgQCGUQLHnvT4A+XMtlBxAhGmODhKi2eik/ki44uB4knPO+lzXxd1zTTA2IbRGH0sc4qG6OZi9XcXdpe4gdyZ+EZrD+TD4Av/gPdlKTv3zzzrz/+IvMNmemZy7CE0klqaMD//O2lSSqqbv5CSSZTU4CjX5OpDzfoYFrKJr72twAHtKQ87YiIjvzIyFTlEl0E0mP1hf0O2pOX9a3rwdOtWsafGGoWF9qyFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUPAn1RsX9pqaVkv2cX9SVna+2x2IlHyRMmjk8jFHCw=;
 b=JhpNFnE0tORyLAL0Tja9CdGh4lm4sqGlV07zlNn+pzlJUOCeFF21V+z+YI5KmYPo1zYccx7i3204hcB3U288U8LMIG67ZIxBoD25n4UkezuJw3e+gKQtY6lrG8xXnxKiaxgzljtFZfCX8R8FuKVE0JA27a+xVZRyCW3yeN/2HQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6069.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 14:00:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:00:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 15:00:51 +0100
Message-Id: <DJ4KNCHX2K2Y.6MYO8HO6VJ1I@garyguo.net>
Cc: <hca@linux.ibm.com>, <gor@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Jan Polensky"
 <japo@linux.ibm.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
 <DJ3VN4EYXCUA.18YA9379UHT5Z@garyguo.net>
 <aicb5a1_SG5B_ByM@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6f4baa3d-07fe-417a-a46c-c7328e026bf1-agordeev@linux.ibm.com>
In-Reply-To: <6f4baa3d-07fe-417a-a46c-c7328e026bf1-agordeev@linux.ibm.com>
X-ClientProxiedBy: PA7P264CA0538.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 44259d55-ce3a-4323-55e5-08dec62f84e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|10070799003|376014|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i+qF/1Orja4JN7Rd9GtN+X5p7N5s59f0/2Tt/SxfNXQprMRW7Axh8Y4+N9fajoj9JJmLdo4I2Xo/sKdh0SQ2lWa/dTFlXDgJV8lvGNqwpMeSS2zapH3L88+58Ozekx6Ei+Nf78PvbQc9hphqjYhf4qC3jiAu0VTiPqZ/53WSAWCbTX77bv2ej0qacaEZE1gKMFBqxV6O/837urDPu4jQtSdyD0MMeZW/E48FjnAl2LaUbo2NAKbvDSgf6yBrRQhLLgwdBfJyBWKX8UN2jmefTEaxd+MjlRO2jPX6544889Uf4jH9HPIqRA4cGHpq054dVq0ddX4WNdwedtS5+s6wpeOOBJQI3eKEGArf+zwKrzOqeRG7LIH8JiPTSXHOE9sy+DCqCMWZGpKixgZhHOXfn70ff4acDNhXjM2llrutTQhqcWoAw6wW88BDoorIhWzhFQLr1fTEJekQ2UAb6i8FgaYbuIank14iDdr5XIicOwWaDBRY80HynIE49YaBc1L1lj+KRHq4qs1KxaCOfip2F3mulQtDcnJmCZPDF8wmkANsNB58R5rxB4FPmFdzDo+pzRGUAmSmh5Ja7BSgldkKULh9z9I+sX2zCipg0g+zbXNuAWXTCZ8AtC88lJO532TQgVEVNcRq6sSCev8wXACXc+D/SoPBUeVtsbLWrjqk11B027bTsXHm2TMnhACAb0Q1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkwvT0ZGZFNFaWx6TGorUGN3dGVRNjBKdmJIZGZ3bi9paWJDT2lWUFVQRVFn?=
 =?utf-8?B?cEorYkRxNDVyZzVSdWNLb3VXTFZkN0oxTlAzbGpGTkRyMXpPRU5jaDZqZzl4?=
 =?utf-8?B?M0FxajhlSmlwbDJFeU5IbnVSa2llS0tBVVdwTkY4RUIrMU9uQnNWSHJ3Tjdk?=
 =?utf-8?B?MmlxOWpkNjBXM3pDU2prNExKdGdxd2dNRmlVUk9QeTJHQUw4SFJrb0I5YjN1?=
 =?utf-8?B?TEw1RHJNeXpiWWplV2lBK2hHVTZpNVZxZG5KcTAzVWxHT3dJcjVLQVNVWUJ4?=
 =?utf-8?B?azI4MGVWZ2ZOWUhZTTZOREhCUnFYWmZ4ZXQ0YzFTNityeFFSbS9mazI5VGND?=
 =?utf-8?B?UHcrV0hkNXBTd3g0S1NLVmVQV0hTVXQ5U0k2OTJXNmJKa09JRHVZaHlEK3lH?=
 =?utf-8?B?bENRYndudFR0ekhCVnFxMkROdHlONFlZVTdjdkt6ZlRZZlprRWJZUnFWaWM1?=
 =?utf-8?B?VmtObTlpVVRKUGdoQXo3VHZvTEpoSWN2djhBM2grYWMzR29WU1V4SGxtN085?=
 =?utf-8?B?d1pkcE5TRG8yOGU2TXZFSVY0YlhxVHRINVp1YldEeGZIQk5sZ09hekpFdmJQ?=
 =?utf-8?B?clF0MmxhamxFUG1ETk9aTEJXbkhpWkNmRFJwV2RlVEs0L3RUK2dMWUVUNVRC?=
 =?utf-8?B?ZkNPZThNTjFYczZTY244REJQSjRnWmZnZWhjN3pNSVR1YVNuWEtlVGFnSXJo?=
 =?utf-8?B?YXhwTzJXcFJXWVdoUFVIRTdrYVAzNERrRTQvNTBCcjhrZ1BEOFRmeUM5WlFp?=
 =?utf-8?B?SFRUV0VxNkxiaTVrbzBURkxDdThpWUVNczIyUlpsMzNxdjFuZHlIY3JTbXBC?=
 =?utf-8?B?TU5WSmNUQTNUQjJvSGgwYjk3TDFNWUJ5cFp5ZE5wS1k0alZseHh5aE9yOFBN?=
 =?utf-8?B?WjhNVnRFRWhrYm5kQktjb0ltclAxR0FCTFVLTCtTOFdRV0VXYjdEeU5objYz?=
 =?utf-8?B?bWRwNTJnNE0yRWFEMTcwRjZaTHhpTVZDU2JacUtRMTRzL2RtS1ZPeTBMcWRq?=
 =?utf-8?B?eEtWODJhaUROOWczMkxrWDhqdEYwdzFieUJTY2Z1MzROdWZZaE82MHAwZS9E?=
 =?utf-8?B?ekUwU1VoeCtqNGp0Tmg3NldzbHZWaEV3NVZZRjNyYURjaXZIenRBb1QrSTVT?=
 =?utf-8?B?N242c2E5blZIaXdTb3pKMS81UTQ2b09hS2l4SHJTS0tjVXp2amVUTXovUlVz?=
 =?utf-8?B?dHdaTUVCdFNsamZUem1mdXoyMVdQa3RLYkx4N3JZeXJjWkE4bE5qRGNwZmFP?=
 =?utf-8?B?dC9Sb0RJUmFxTVY3a0d3bEJ5TXFjSllPSjdONk5OVnJoN0tBdGtvbzlzcVMw?=
 =?utf-8?B?blZKWEk3WFFDU0dWQlduOXlVenNybHVtTEZmeHpDVWlpMUdJdytzb0hLK0JC?=
 =?utf-8?B?dHBHMHdDL0FzVUtxUGpBQ1RQWnY0aTNRdm9IZExCSnFhbms4UVZYK0lRVFNI?=
 =?utf-8?B?VjRnZXBPRitIa3lmaGNrejZBYlJZc0szOTBITXppcUQ4SGtUVGs2cXh2Tjkv?=
 =?utf-8?B?ODVDbnNjb3M4SUtZR2l5R2xIcEw4OW5CaFk2SkZ3dnF6ZkIyU2FxaVAvWGQw?=
 =?utf-8?B?SGl4NXo3RmpVWkYxMUd5SkZvZjJlMk5WeTJSUER0cGNXWlJXZVV3MWl0TnRM?=
 =?utf-8?B?QysyaXBYbGI4M1RHODAvckFpL1VUZVlRRjJDVFpsWUFxV2JVTmVCZkFKMjVX?=
 =?utf-8?B?UWE5WWpoTDJjNVYvci9RWnErcnF4eHRoZTR5ODR5UStmdUpWNEg5ZXd3dzln?=
 =?utf-8?B?L3hKSDJpSXNLSmZmK3JmTms4cFVISVVJaVc4ZmlDVjRzcTNjMWhIMnViSXNE?=
 =?utf-8?B?aiswVDZWT2I1WjZ5QWtYZFpmQnYvZkNwZ0ZSbE9McHgxeHQ0aGhWaDl4K1hv?=
 =?utf-8?B?b3VEY0pxRmt5QjRkalkvTXRXNUh0VWkrdmZiQTVQekZ4L1RXU2ZVdVNDUnZS?=
 =?utf-8?B?VUt6a0I0cGZ6WU1CbFU5L2cyd3NJdVE3MmFHQU9tSEpCVUFOWjhDdFE4S081?=
 =?utf-8?B?dXRpT1pkdC9aNlhWMVNXcS9XN3hyK0JHa1VSM1lUeDJ2QUd2NkpqR2RpeVov?=
 =?utf-8?B?aEkrcjdvTlBhV3Z6N2cyVVlKU3hxQ0w2b05FNXZzWDF5a1R4V0R1MjduTnFa?=
 =?utf-8?B?MWs4TmxQOTdWc2g3RW1KZy9PRk9leDVaeUFNdFZYWWRzZTNhNVZOZ0phZFNl?=
 =?utf-8?B?WTVPTEUvK0JNOFE4WDNBL1l6Qjl6QzcwZ0p1WThhQ2ptaDVSRUxpVlA0NmtT?=
 =?utf-8?B?bHlBNEcwbHRrZU1ENXo4R21YYmtmWVgveWhvZVNEcnY3aURCQ1hJaWNVVmpu?=
 =?utf-8?B?NTRkQ0xoRkhheW5NWkM3WllaOHJya1VhNDk4WTF0ekRNVFpXYUd2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 44259d55-ce3a-4323-55e5-08dec62f84e8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:00:52.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhmL3uLCsZ/jQvpm3xUvAmCxRwTlped6QjLOs+MR08Gnb31O+m73wYwPZImE42sPm6vPJvxguOCXV9GMXGnmvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6069

On Tue Jun 9, 2026 at 2:51 PM BST, Alexander Gordeev wrote:
> On Mon, Jun 08, 2026 at 09:45:41PM +0200, Jan Polensky wrote:
>
> Hi Gary!
>
> ...
>
>> Backend support is planned, but has not been implemented yet. Until then=
,
>> keeping Rust support gated behind !CONFIG_EXPOLINE is the intentional an=
d
>> conservative choice for this series.
>
> Is there anything in this series of concern to you?
>
> Thanks!

It looks okay to me. Feel free to add my acks for patches that don't have a=
ny
yet.

Best,
Gary
