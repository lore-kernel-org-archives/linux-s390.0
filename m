Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CB1991D4;
	Fri,  3 Apr 2026 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775188920; cv=none; b=Lf4Ol3PYVEIyzprtlMGyoi7NPUy0vdLmITNnsSCDThXWm2IPPSZihiqQkzWyobOUqn2hd/u8ZsK0WDXBrG2niCFjLx9m6IiqJ3UZH4K0CTw6YYizcznH6+7Ej/de2s2jdF9W5ELCgffXBCxhUZR/F50cTj1l9ohyeAc7oUqafTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775188920; c=relaxed/simple;
	bh=KlhxTTbe0S2+L2xbVGidcgd76YiRASLn6uvcswLCaVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTzg6EyCU97LpMkXx8gNcLRj5RYqb/KFBWbSYJljU0lat+L9TDDI4J1Zus6Ss+JrYaAOwAevI+JF9pt6BOL71cLwSXxW1KmeRGgi6PPs9m7DPucUxcwFfsv/8l95+FiAhEDuFpDIkl/C4vNXbhefGNIp7I4bnQbYro2ictr/5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=axqu/+VV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axqu/+VV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hth5ItCsj8A6hKUrhr9C+dhAotpxXmKlU+z7J5ngyAs=; b=axqu/+VVT6ssg7tTfhgTd3VnKT
	tgUc58iew4NhtlTgUr4eXMDUnxW9TgpQU0xCsYZemdwFASZftVgX1nz8vDwosnYpxmhtPMpLw7NM2
	vrArPgkmwABZfC94lJkTqzvL5OiwjzZZCM3vM8y9O+WpFvvVwUBfPUuQdscelSWQn8b8OM24GJmmh
	jnIsLTRShUhecssRcahCiRyNpRsrHAFT/K9FerX8ktETyaXqSMu2Ci5dwVLQHrM8Ss0Wa/dQe8Xio
	N6an47614s2aNsAe30Odxw86oaY6NanalJYUIl11UwiT3ewrQrlN1+vRdk4xEicFglvD4eo2FGX+J
	rubVJiVg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8VjB-00000001Ak3-4BmC;
	Fri, 03 Apr 2026 04:01:50 +0000
Message-ID: <9e1cc48c-79ea-486a-96f4-a1d1395d7e47@infradead.org>
Date: Thu, 2 Apr 2026 21:01:47 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] docs: s390/pci: Improve and update PCI
 documentation
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Julian Ruess <julianr@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Ramesh Errabolu <ramesh@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
 <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260402-uid_slot-v6-1-d5ea0a14ddb9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/2/26 1:34 PM, Niklas Schnelle wrote:
> Update the s390 specific PCI documentation to better reflect current
> behavior and terms such as the handling of Isolated VFs via commit
> 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs").
> 
> Add a descriptions for /sys/firmware/clp/uid_is_unique which was added
> in commit b043a81ce3ee ("s390/pci: Expose firmware provided UID Checking
> state in sysfs") but missed documentation.
> 
> Similarly add documentation for the fidparm attribute added by commit
> 99ad39306a62 ("s390/pci: Expose FIDPARM attribute in sysfs") and
> add a list of pft values and their names.
> 
> Finally improve formatting of the different attribute descriptions by
> adding a separating colon.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  Documentation/arch/s390/pci.rst | 139 +++++++++++++++++++++++++++-------------
>  1 file changed, 94 insertions(+), 45 deletions(-)


These changes are good, so:
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


However, I would go a little farther and add these changes if you
are OK with them. (Patch applies after both of your patches.)

-- 
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/arch/s390/pci.rst |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- linux-next-20260401.orig/Documentation/arch/s390/pci.rst
+++ linux-next-20260401/Documentation/arch/s390/pci.rst
@@ -36,7 +36,8 @@ in sysfs directories of the form:
 For example:
 
   - /sys/kernel/debug/s390dbf/pci_msg/sprintf
-    Holds messages from the processing of PCI events, like machine check handling
+
+    holds messages from the processing of PCI events, like machine check handling
     and setting of global functionality, like UID checking.
 
   Change the level of logging to be more or less verbose by piping
@@ -57,8 +58,8 @@ Entries specific to zPCI functions and e
 
   - /sys/bus/pci/slots/XXXXXXXX/power
 
-  In addition to using the FID as the name of the slot the slot directory
-  also contains the following s390 specific slot attributes.
+  In addition to using the FID as the name of the slot, the slot directory
+  also contains the following s390-specific slot attributes.
 
   - uid:
     The User-defined identifier (UID) of the function which may be configured
@@ -71,22 +72,22 @@ Entries specific to zPCI functions and e
 * /sys/bus/pci/devices/DDDD:BB:dd.f/:
 
   - function_id:
-    The zPCI function identifier (FID) is a 32 bit hexadecimal value that
+    The zPCI function identifier (FID) is a 32-bit hexadecimal value that
     uniquely identifies the PCI function. Unless the hypervisor provides
     a virtual FID e.g. on KVM this identifier is unique across the machine even
     between different partitions.
 
   - function_handle:
-    This 32 bit hexadecimal value is a low-level identifier used for a PCI
+    This 32-bit hexadecimal value is a low-level identifier used for a PCI
     function. Note that the function handle may be changed and become invalid
     on PCI events and when enabling/disabling the PCI function.
 
   - pchid:
-    This 16 bit hexadecimal value encodes a model-dependent location for
+    This 16-bit hexadecimal value encodes a model-dependent location for
     the PCI function.
 
   - pfgid:
-    PCI function group ID, functions that share identical functionality
+    PCI function group ID; functions that share identical functionality
     use a common identifier.
     A PCI group defines interrupts, IOMMU, IOTLB, and DMA specifics.
 
@@ -95,7 +96,7 @@ Entries specific to zPCI functions and e
     0 for physical functions.
 
   - pft:
-    The PCI function type is an s390 specific type attribute. It indicates
+    The PCI function type is an s390-specific type attribute. It indicates
     a more general, usage oriented, type than PCI Specification
     class/vendor/device identifiers. That is PCI functions with the same pft
     value may be backed by different hardware implementations. At the same time
@@ -124,7 +125,7 @@ Entries specific to zPCI functions and e
     not applicable for that PCI function type.
 
   - uid:
-    The user-defined identifier (UID) for a PCI function is a 32 bit
+    The user-defined identifier (UID) for a PCI function is a 32-bit
     hexadecimal value. It is defined on a per instance basis as part of the
     partition, KVM guest, or z/VM guest configuration. If UID Checking is
     enabled the platform ensures that the UID is unique within that instance
@@ -146,7 +147,7 @@ Entries specific to zPCI functions and e
     The more the segments are different, the more the functions are isolated.
 
   - fidparm:
-    Contains an 8 bit per PCI function parameter field in hexadecimal provided
+    Contains an 8-bit-per-PCI function parameter field in hexadecimal provided
     by the platform. The meaning of this field is PCI function type specific.
     For NETH VFs a value of 0x01 indicates that the function supports
     promiscuous mode.
@@ -164,13 +165,13 @@ The PCI address consists of four parts:
 and is of this form: DDDD:BB:dd.f.
 
 * For a PCI function for which the platform does not expose the RID, the
-  pci=norid kernel parameter is used, or a so called isolated Virtual Function
+  pci=norid kernel parameter is used, or a so-called isolated Virtual Function
   which does have RID information but is used without its parent Physical
   Function being part of the same PCI configuration:
 
   - There is only one function per domain.
 
-  - The domain is set from the zPCI function's UID if UID Checking is on
+  - The domain is set from the zPCI function's UID if UID Checking is on;
     otherwise the domain ID is generated dynamically and is not stable
     across reboots or hot plug.
 

