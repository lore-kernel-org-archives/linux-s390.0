From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path event
 handling
Date: Fri, 12 Jan 2018 19:10:20 +0100
Message-ID: <f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 01/11/2018 04:04 AM, Dong Jia Shi wrote:
> What are still missing, thus need to be offered in the next version are:
> - I/O termination and FSM state handling if currently we have I/O on the status
>   switched path.
> - Vary on/off event is not sensible to a guest.

I don't see a doc update. We do have documentation (in
Documentation/s390/vfio-ccw.txt) in which the uapi interface with the
regions and their purpose/usage  is at least kind of explained. You are
changing this interface without updating the doc.

I would like to see documentation on this because I'm under the
impression either the design is pretty convoluted or I did not
get it at all.

Regards,
Halil
