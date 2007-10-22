Return-Path: <linux-kernel-owner+w=401wt.eu-S1754581AbXJVDrG@vger.kernel.org>
Message-ID: <471C1D29.5020403@gmail.com>
Date: Sun, 21 Oct 2007 23:46:49 -0400
From: emist <emistz@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Bug fix for the s390 dcssblk driver
References: <200710201451.57138.elendil@planet.nl> <471A39D2.1070303@gmail.com> <20071021100926.GA4420@osiris.ibm.com>
In-Reply-To: <20071021100926.GA4420@osiris.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010307020508060901070905"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linux <linux-kernel@vger.kernel.org>
Cc: geraldsc@de.ibm.com, cotte@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010307020508060901070905
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Heiko Carstens wrote:
> On Sat, Oct 20, 2007 at 01:24:34PM -0400, emist wrote:
>> Frans Pop wrote:
>>> emist wrote:
>>>> The following patch fixes and issue in the s390 dcssblk driver. The
>>>> issue is caused when an unsuccessful attempt is made in order to change
>>>> a segment's type through the device attribute file "shared". This causes
>>>> the driver to remove the device in question, removing with it the device
>>>> attribute which is currently handling the call. The result is a hang on
>>>> the driver as it removes memory from under its feet.
>>>>
>>>> Not exactly sure if this explanation makes sense or its entirely
>>>> accurate. This is what I believe at this point from encountering and
>>>> fixing the error. Anyway here is the patch, hope it helps.
>>> Hi,
>>>
>>> If you don't get any reactions to your patch during the next few days, I 
>>> suggest you resend it and then CC the linux-s390@vger.kernel.org list and 
>>> possibly also the maintainer at linux390@de.ibm.com.
>>>
>>> In general you should always try to CC the relevant list/people as listed in 
>>> the MAINTAINERS file and not just the linux-kernel list, both for patches 
>>> and when reporting problems.
>>>
>>> Cheers,
>>> Frans Pop
>>>
>> Thanks Frans, I will do as you suggest.
>>
>> Have a good one,
>>
>> Igor H.
> 
> Gerald or Carsten (cc'ed) should look into this.
> Thanks for reporting.
> 

Hello,

I realized that I did not fix one of the cases where this bug manifests
in my last patch. Here is the complete patch to fix the issue. And this
time I cc'ed the relevant people.

Have a good one,

Igor H.



--------------010307020508060901070905
Content-Type: text/plain;
 name="dcssblk_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dcssblk_fix"

# This patch fixes a memory corruption bug in the s390 dcssblk driver.
# The bug occurs when an attempt to change the type of a segment
# returns an error. At this point the driver tries to remove the segment in
# question while some of the device's attributes are in use. This causes the
# driver to hang.
#
# questions/comments @ emistz@gmail.com


diff -urN linux-2.6.23.1/drivers/s390/block/dcssblk.c linuxx/drivers/s390/block/dcssblk.c
--- linux-2.6.23.1/drivers/s390/block/dcssblk.c	2007-10-20 01:19:29.000000000 -0400
+++ linuxx/drivers/s390/block/dcssblk.c	2007-10-20 01:16:13.000000000 -0400
@@ -230,8 +230,15 @@
 					   SEGMENT_SHARED);
 		if (rc < 0) {
 			BUG_ON(rc == -EINVAL);
-			if (rc != -EAGAIN)
-				goto removeseg;
+			if (rc != -EAGAIN){
+						PRINT_DEBUG
+				    ("Could not reload segment %s in the specified format, reloading\n",
+				     dev_info->segment_name);
+				rc = segment_modify_shared(dev_info->
+							   segment_name,
+							   SEGMENT_EXCLUSIVE);
+				goto out;
+			}
 		} else {
 			dev_info->is_shared = 1;
 			switch (dev_info->segment_type) {
@@ -253,8 +260,12 @@
 					   SEGMENT_EXCLUSIVE);
 		if (rc < 0) {
 			BUG_ON(rc == -EINVAL);
-			if (rc != -EAGAIN)
-				goto removeseg;
+			if (rc != -EAGAIN){
+				PRINT_DEBUG("Could not reload segment %s in the specified format, reloading\n",
+					dev_info->segment_name);
+				rc = segment_modify_shared(dev_info->segment_name, SEGMENT_SHARED);
+				goto out;	
+			}
 		} else {
 			dev_info->is_shared = 0;
 			set_disk_ro(dev_info->gd, 0);

--------------010307020508060901070905--
