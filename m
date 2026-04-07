Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879221B905;
	Tue,  7 Apr 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570987; cv=none; b=KJ/SGg+teuzC803tFSClGRrmJKOcm18ETb8g4s8T2b43yDqr8hQBaDmTXcNblWy+nYXSatYHd9IoY7d2ut037/q6fiyVHwk/88QLg7tJh2uqY5mwyZ0tH0e8o+2FHLUyD4lQlhnwcQM7zUDjp2SUC3M8VBajtcxRtNhNr1uVTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570987; c=relaxed/simple;
	bh=XnwiCsmEcuWDjxJxrnaxNtBHuHhu0PK3ZIwTCNUkobM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awIdGSi80x2YwHIUqfemXUfqLIuoC4vDrWnL+KnEiHUIAO1rDW6+gtYXyLVH2Y/rn2pzUk0yYl1xLywXImdUyeJ0XI1ww1FbqzG/2fmsJsjPCHc65cVPzMizO9y+M1nT+n2ucslK4+SmZVwFXEvtyQ1HXLf+9Gk+ul/gbqAv3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QxNMOD6E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QxNMOD6E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmNrO2211629;
	Tue, 7 Apr 2026 14:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5BHmH1
	qcrKX6nEAPwYwIzUiePgOYyUqiQFrv6TNXfQI=; b=QxNMOD6EzPCWA9gTGRSP9S
	KWzouiHx+nIJxo9Htm+OdroOnmzTjdH5lbCvKMNz3qINZ37bL/qDdxqT65ZwW1XO
	0uUEt8N5WxOrDhKSianNViidQMEcv+CHhtoG+ZPzzYmKUYMLnFumpE/YpDx6m56r
	P8qOIMv/dF6XRe4dD70QdKYnRFVqn8YgT2w9R1EQuJEZgBXDK3JyJG9sgqs4ZNq4
	wC3hAI28hvEFxQqtboA9QYI0hLCqXZyevHkmY3f8Y/TF1RqTnvhu1AhALHvepR5o
	xUDp5EXT3hjFWdVMwskt2oQ71zzmjayPOARG/gvAx5O6TmaJyunPwrmA4tvBkZcA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hb23g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 14:09:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BRISD007898;
	Tue, 7 Apr 2026 14:09:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2bf87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 14:09:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637E9YPG32702904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 14:09:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4651420043;
	Tue,  7 Apr 2026 14:09:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54DB20040;
	Tue,  7 Apr 2026 14:09:33 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 14:09:33 +0000 (GMT)
Message-ID: <15f9e61239cd8f8b09bb0f058848e80070c0b1de.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/2] docs: s390/pci: Improve and update PCI
 documentation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas
	 <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Lukas Wunner
	 <lukas@wunner.de>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens	 <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato	
 <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Randy Dunlap	
 <rdunlap@infradead.org>,
        Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 07 Apr 2026 16:09:33 +0200
In-Reply-To: <20260407-uid_slot-v8-1-15ae4409d2ce@linux.ibm.com>
References: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
	 <20260407-uid_slot-v8-1-15ae4409d2ce@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyOCBTYWx0ZWRfX3/bjssKjfKwn
 odcWNAND3qPV1HFYn7EZtYuT0CqI2kjFImxjkBntee6VGImKtx1cK+rRfThIm5/Rnh/Wp33zX84
 nmUNd0dbyi5hG37TDebpywFne2Iym5WpxViyHvkRJWuLu2dxmuVXuE1IvoA4s6Q+xzTKaHA+lvS
 jre3uRtLa0lA8e7zuqkL/8pbOVAf+f8wlDH6e2+VQPEn0LLRxD7WFqvLERghzftsu99ehRTvLLv
 rfPnq4XzizZ0bqOCkMUoG+K+hP0MOZHFJvQnWbsf+EN/zXCq3xienD5w2bmRyEqgXrcpbY+Cxwc
 oSvoxjodXIoKUwWjKFMGaBMcuSWnTO4cN1fLDTxj7GpBOKhYJIYKqHkxvf2fPjj6uV3ulBHZGgn
 ih/+SGUxnsGlDhvk1565dpV76NDyvoMEk/u0Hk4oJP15hxydm2b/PIDLQUj5c7xEvAr6rP1a5Cj
 A5Qw3FDfdcWp64+PwHg==
X-Proofpoint-GUID: RIR04Ww7cB2nuKzvY-eaaRsoI-ELMCoe
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d51023 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JfrnYn6hAAAA:8 a=oSjUTuWWw7jTxM-3NScA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: MCThKNEXiNn67KqjnVd3jROGsLURPsS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070128

On Tue, 2026-04-07 at 15:24 +0200, Niklas Schnelle wrote:
> Update the s390 specific PCI documentation to better reflect current
> behavior and terms such as the handling of Isolated VFs via commit
> 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs").
>=20
> Add a descriptions for /sys/firmware/clp/uid_checking which was added
> in commit b043a81ce3ee ("s390/pci: Expose firmware provided UID Checking
> state in sysfs") but missed documentation.
>=20
> Similarly add documentation for the fidparm attribute added by commit
> 99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
> add a list of pft values and their names.
>=20
> Finally improve formatting of the different attribute descriptions by
> adding a separating colon.
>=20
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  Documentation/arch/s390/pci.rst | 144 +++++++++++++++++++++++++++-------=
------
>  1 file changed, 97 insertions(+), 47 deletions(-)
>=20
> diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pc=
i.rst
> index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..c3476de4f03278d07099aa32c=
bea0f868b6e9c9c 100644
> --- a/Documentation/arch/s390/pci.rst
> +++ b/Documentation/arch/s390/pci.rst
> @@ -6,6 +6,7 @@ S/390 PCI
> =20
>  Authors:
>          - Pierre Morel
> +        - Niklas Schnelle
> =20
>  Copyright, IBM Corp. 2020
> =20
> @@ -27,14 +28,16 @@ Command line parameters
>  debugfs entries
>  ---------------
> =20
> -The S/390 debug feature (s390dbf) generates views to hold various debug =
results in sysfs directories of the form:
> +The S/390 debug feature (s390dbf) generates views to hold various debug =
results
> +in sysfs directories of the form:
> =20
>   * /sys/kernel/debug/s390dbf/pci_*/
> =20
>  For example:
> =20
>    - /sys/kernel/debug/s390dbf/pci_msg/sprintf
> -    Holds messages from the processing of PCI events, like machine check=
 handling
> +
> +    holds messages from the processing of PCI events, like machine check=
 handling
>      and setting of global functionality, like UID checking.
> =20
>    Change the level of logging to be more or less verbose by piping
> @@ -47,87 +50,134 @@ Sysfs entries
> =20
>  Entries specific to zPCI functions and entries that hold zPCI informatio=
n.
> =20
> -* /sys/bus/pci/slots/XXXXXXXX
> +* /sys/bus/pci/slots/XXXXXXXX:
> =20
> -  The slot entries are set up using the function identifier (FID) of the
> -  PCI function. The format depicted as XXXXXXXX above is 8 hexadecimal d=
igits
> -  with 0 padding and lower case hexadecimal digits.
> +  The slot entries are set up using the function identifier (FID) of the=
 PCI
> +  function as slot name. The format depicted as XXXXXXXX above is 8 hexa=
decimal
> +  digits with 0 padding and lower case hexadecimal digits.
> =20
>    - /sys/bus/pci/slots/XXXXXXXX/power
> =20
>    A physical function that currently supports a virtual function cannot =
be
>    powered off until all virtual functions are removed with:
> -  echo 0 > /sys/bus/pci/devices/XXXX:XX:XX.X/sriov_numvf
> +  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
> =20
> -* /sys/bus/pci/devices/XXXX:XX:XX.X/
> +* /sys/bus/pci/devices/DDDD:BB:dd.f/:
> =20
> -  - function_id
> -    A zPCI function identifier that uniquely identifies the function in =
the Z server.
> +  - function_id:
> +    The zPCI function identifier (FID) is a 32-bit hexadecimal value tha=
t
> +    uniquely identifies the PCI function. Unless the hypervisor provides
> +    a virtual FID e.g. on KVM this identifier is unique across the machi=
ne even
> +    between different partitions.
> =20
> -  - function_handle
> -    Low-level identifier used for a configured PCI function.
> -    It might be useful for debugging.
> +  - function_handle:
> +    This 32-bit hexadecimal value is a low-level identifier used for a P=
CI
> +    function. Note that the function handle may be changed and become in=
valid
> +    on PCI events and when enabling/disabling the PCI function.
> =20
> -  - pchid
> -    Model-dependent location of the I/O adapter.
> +  - pchid:
> +    This 16-bit hexadecimal value encodes a model-dependent location for
> +    the PCI function.
> =20
> -  - pfgid
> -    PCI function group ID, functions that share identical functionality
> +  - pfgid:
> +    PCI function group ID; functions that share identical functionality
>      use a common identifier.
>      A PCI group defines interrupts, IOMMU, IOTLB, and DMA specifics.
> =20
> -  - vfn
> +  - vfn:
>      The virtual function number, from 1 to N for virtual functions,
>      0 for physical functions.
> =20
> -  - pft
> -    The PCI function type
> +  - pft:
> +    The PCI function type is an s390-specific type attribute. It indicat=
es
> +    a more general, usage oriented, type than PCI Specification
> +    class/vendor/device identifiers. That is PCI functions with the same=
 pft
> +    value may be backed by different hardware implementations. At the sa=
me time
> +    apart from unclassified functions (pft is 0x00) the same pft value
> +    generally implies a similar usage model. At the same time the same
> +    PCI hardware device may appear with different pft values when in a
> +    different usage model. For example NETD and NETH VFs may be implemen=
ted
> +    by the same PCI hardware device but in NETD the parent Physical Func=
tion
> +    is user managed while with NETH it is platform managed.
> =20
> -  - port
> -    The port corresponds to the physical port the function is attached t=
o.
> -    It also gives an indication of the physical function a virtual funct=
ion
> -    is attached to.
> +    Currently the following PFT values are defined:
> =20
> -  - uid
> -    The user identifier (UID) may be defined as part of the machine
> -    configuration or the z/VM or KVM guest configuration. If the accompa=
nying
> -    uid_is_unique attribute is 1 the platform guarantees that the UID is=
 unique
> -    within that instance and no devices with the same UID can be attache=
d
> -    during the lifetime of the system.
> +    - 0x00 (UNC): Unclassified
> +    - 0x02 (ROCE): RoCE Express
> +    - 0x05 (ISM): Internal Shared Memory
> +    - 0x0a (ROC2): RoCE Express 2
> +    - 0x0b (NVMe): NVMe
> +    - 0x0c (NETH): Network Express hybrid
> +    - 0x0d (CNW): Cloud Network Adapter
> +    - 0x0f (NETD): Network Express direct
> =20
> -  - uid_is_unique
> -    Indicates whether the user identifier (UID) is guaranteed to be and =
remain
> -    unique within this Linux instance.
> +  - port:
> +    The port is a decimal value corresponding to the physical port the f=
unction
> +    is attached to. Virtual Functions (VFs) share the port with their pa=
rent
> +    Physical Function (PF). A value of 0 indicates that the port attribu=
te is
> +    not applicable for that PCI function type.
> =20
> -  - pfip/segmentX
> +  - uid:
> +    The user-defined identifier (UID) for a PCI function is a 32-bit
> +    hexadecimal value. It is defined on a per instance basis as part of =
the
> +    partition, KVM guest, or z/VM guest configuration. If UID Checking i=
s
> +    enabled the platform ensures that the UID is unique within that inst=
ance
> +    and no two PCI functions with the same UID will be visible to the in=
stance.
> +
> +    Independent of this guarantee and unlike the function ID (FID) the U=
ID may
> +    be the same in different partitions within the same machine. This al=
lows to
> +    create PCI configurations in multiple partitions to be identical in =
the
> +    UID-namespace.
> +
> +  - uid_is_unique:
> +    A 0 or 1 flag indicating whether the user-defined identifier (UID) i=
s
> +    guaranteed to be and remain unique within this Linux instance. This
> +    platform feature is called UID Checking.
> +
> +  - pfip/segmentX:
>      The segments determine the isolation of a function.
>      They correspond to the physical path to the function.
>      The more the segments are different, the more the functions are isol=
ated.
> =20
> +  - fidparm:
> +    Contains an 8-bit-per-PCI function parameter field in hexadecimal pr=
ovided
> +    by the platform. The meaning of this field is PCI function type spec=
ific.
> +    For NETH VFs a value of 0x01 indicates that the function supports
> +    promiscuous mode.
> +
> +* /sys/firmware/clp/uid_checking:
> +
> +  In addition to the per-device uid_is_unique attribute this presents a
> +  global indication of whether UID Checking is enabled. This allows user=
s
> +  to check for UID Checking even when no PCI functions are configured.
> +
>  Enumeration and hotplug
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The PCI address consists of four parts: domain, bus, device and function=
,
> -and is of this form: DDDD:BB:dd.f
> +and is of this form: DDDD:BB:dd.f.
> =20
> -* When not using multi-functions (norid is set, or the firmware does not
> -  support multi-functions):
> +* For a PCI function for which the platform does not expose the RID, the
> +  pci=3Dnorid kernel parameter is used, or a so-called isolated Virtual =
Function
> +  which does have RID information but is used without its parent Physica=
l
> +  Function being part of the same PCI configuration:
> =20
>    - There is only one function per domain.
> =20
> -  - The domain is set from the zPCI function's UID as defined during the
> -    LPAR creation.
> +  - The domain is set from the zPCI function's UID if UID Checking is on=
;
> +    otherwise the domain ID is generated dynamically and is not stable
> +    across reboots or hot plug.
> =20
> -* When using multi-functions (norid parameter is not set),
> -  zPCI functions are addressed differently:
> +* For a PCI function for which the platform exposes the RID and which
> +  is not an Isolated Virtual Function:
> =20
>    - There is still only one bus per domain.
> =20
> -  - There can be up to 256 functions per bus.
> +  - There can be up to 256 PCI functions per bus.
> =20
> -  - The domain part of the address of all functions for
> -    a multi-Function device is set from the zPCI function's UID as defin=
ed
> -    in the LPAR creation for the function zero.
> +  - The domain part of the address of all functions within the same topo=
logy is
> +    that of the configured PCI function with the lowest devfn within tha=
t
> +    topology.
> =20
> -  - New functions will only be ready for use after the function zero
> -    (the function with devfn 0) has been enumerated.
> +  - Virtual Functions generated by an SR-IOV capable Physical Function o=
nly
> +    become visible once SR-IOV is enabled.


LGTM!
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
