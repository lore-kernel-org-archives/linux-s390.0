Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
References: <20210112215004.GA1855697@bjorn-Precision-5520>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <4f5013a1-3dde-1633-a0cc-591fc439e29d@linux.ibm.com>
Date: Wed, 13 Jan 2021 08:47:58 +0100
MIME-Version: 1.0
In-Reply-To: <20210112215004.GA1855697@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>



On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
> On Mon, Jan 11, 2021 at 10:38:57AM +0100, Niklas Schnelle wrote:
>> We use the UID of a zPCI adapter, or the UID of the function zero if
>> there are multiple functions in an adapter, as PCI domain if and only if
>> UID Checking is turned on.
>> Otherwise we automatically generate domains as devices appear.
>>
>> The state of UID Checking is thus essential to know if the PCI domain
>> will be stable, yet currently there is no way to access this information
>> from userspace.
>> So let's solve this by showing the state of UID checking as a sysfs
>> attribute in /sys/bus/pci/uid_checking
> 
> Cosmetic: can't tell if the above is two paragraphs separated by blank
> lines or four separated by either blank lines or short last lines.
> Please separate or reflow to avoid the ambiguity.

Thanks, you're right I split it in 3 proper paragraphs now.
Also the commit message was out of sync with the documentation,
cover letter and code. This version actually uses
/sys/bus/pci/zpci/uid_checking sorry about that.

> 
> I don't have any input on the s390 issues, and I assume this will go
> via the s390 tree.
> 
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++++
>>  arch/s390/include/asm/pci.h             |  3 +++
>>  arch/s390/pci/pci.c                     |  4 +++
>>  arch/s390/pci/pci_sysfs.c               | 34 +++++++++++++++++++++++++
>>  4 files changed, 52 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 25c9c39770c6..a174aac0ebb0 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -375,3 +375,14 @@ Description:
>>  		The value comes from the PCI kernel device state and can be one
>>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>>  		The file is read only.
>> +What:		/sys/bus/pci/zpci/uid_checking
>> +Date:		December 2020
>> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
>> +Description:
>> +		This attribute exposes the global state of UID Checking on
>> +		an s390 Linux system. If UID Checking is on this file
>> +		contains '1' otherwise '0'. If UID Checking is on the UID of
>> +		a zPCI device, or the UID of function zero for a multi-function
>> +		device will be used as its PCI Domain number. If UID Checking
>> +		is off PCI Domain numbers are generated automatically and
>> +		are not stable across reboots.
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 212628932ddc..3cfa6cc701ba 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -285,6 +285,9 @@ void zpci_debug_exit_device(struct zpci_dev *);
>>  /* Error reporting */
>>  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
... snip ...
>> +
>> +/* Global zPCI attributes */
>> +static ssize_t uid_checking_show(struct kobject *kobj,
>> +				 struct kobj_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%i\n", zpci_unique_uid);
>> +}
>> +
>> +static struct kobj_attribute sys_zpci_uid_checking_attr =
>> +	__ATTR(uid_checking, 0444, uid_checking_show, NULL);
> 
> Use DEVICE_ATTR_RO instead of __ATTR.

It's my understanding that DEVICE_ATTR_* is only for
per device attributes. This one is global for the entire
Z PCI. I just tried with BUS_ATTR_RO instead
and that works but only if I put the attribute at
/sys/bus/pci/uid_checking instead of with a zpci
subfolder. This path would work for us too, we
currently don't have any other global attributes
that we are planning to expose but those could of
course come up in the future.

> 
... snip ...
>>
