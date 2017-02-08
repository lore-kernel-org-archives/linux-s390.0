Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 08 Feb 2017 13:37:44 -0500 (EST)
Message-ID: <20170208.133744.558863839333233338.davem@davemloft.net>
Subject: Re: [PATCH v2 net-next] virtio: Fix affinity for #VCPUs != #queue
 pairs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170207181506.36668-1-serebrin@google.com>
References: <20170207181506.36668-1-serebrin@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20170208183744.8dXG-uqhy57N03w-uaiH-3VdmB670XfZXzds5JX7VXA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: serebrin@google.com
Cc: borntraeger@de.ibm.com, netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, willemb@google.com, venkateshs@google.com, jonolson@google.com, willemdebruijn.kernel@gmail.com, rick.jones2@hpe.com, jmattson@google.com, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ben Serebrin <serebrin@google.com>
Date: Tue,  7 Feb 2017 10:15:06 -0800

> If the number of virtio queue pairs is not equal to the
> number of VCPUs, the virtio guest driver doesn't assign
> any CPU affinity for the queue interrupts or the xps
> aggregation interrupt.  (In contrast, the driver does assign
> both if the counts of VCPUs and queues are equal, which is a good
> default behavior.)
 ...

Can I get some reviews, please?
