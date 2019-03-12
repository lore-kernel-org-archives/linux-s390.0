Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v3] zcrypt: handle AP Info notification from CHSC SEI
 command
References: <1550509295-1199-1-git-send-email-akrowiak@linux.ibm.com>
 <9224eca6-6d2c-7089-1fb2-618a04d7286b@linux.ibm.com>
 <alpine.LFD.2.21.1903111656170.8196@schleppi>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 12 Mar 2019 11:02:08 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1903111656170.8196@schleppi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6117b968-bb06-78e6-1687-9d03b1544099@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 3/11/19 11:57 AM, Sebastian Ott wrote:
> On Mon, 11 Mar 2019, Tony Krowiak wrote:
>> On 2/18/19 12:01 PM, Tony Krowiak wrote:
>>> The current AP bus implementation periodically polls the AP configuration
>>> to detect changes. When the AP configuration is dynamically changed via the
>>> SE or an SCLP instruction, the changes will not be reflected to sysfs until
>>> the next time the AP configuration is polled. The CHSC architecture
>>> provides a Store Event Information (SEI) command to make notification of an
>>> AP configuration change. This patch introduces a handler to process
>>> notification from the CHSC SEI command by immediately kicking off an AP bus
>>> scan-after-event.
>>
>> Ping
> 
> Applied.

Thank you Sebastian.

> 
