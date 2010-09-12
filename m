From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Sun, 12 Sep 2010 02:42:13 +0200
Message-ID: <72A751CE-3F46-4D98-9FAF-BA1C1A95B6EE@suse.de>
References: <1282657732-20902-1-git-send-email-agraf@suse.de> <1282657732-20902-2-git-send-email-agraf@suse.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1282657732-20902-2-git-send-email-agraf@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
List-ID: <linux-s390.vger.kernel.org>


On 24.08.2010, at 15:48, Alexander Graf wrote:

> The one big missing feature in s390-virtio was hotplugging. This is no more.
> This patch implements hotplug add support, so you can on the fly add new devices
> in the guest.
> 
> Keep in mind that this needs a patch for qemu to actually leverage the
> functionality.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>

ping (on the patch set)?


Alex
