Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] af_iucv: Move sockaddr length checks to before accessing
 sa_family in bind and connect handlers
References: <20170613174228.9218-1-mjurczyk@google.com>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 16:49:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170613174228.9218-1-mjurczyk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a2bafded-712e-6e8b-9395-b020c73dc06a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mateusz Jurczyk <mjurczyk@google.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/13/2017 07:42 PM, Mateusz Jurczyk wrote:
> Verify that the caller-provided sockaddr structure is large enough to
> contain the sa_family field, before accessing it in bind() and connect()
> handlers of the AF_IUCV socket. Since neither syscall enforces a minimum
> size of the corresponding memory region, very short sockaddrs (zero or
> one byte long) result in operating on uninitialized memory while
> referencing .sa_family.
> 
> Signed-off-by: Mateusz Jurczyk <mjurczyk@google.com>
Thanks Mateusz!

Fixes: 52a82e23b9f2
Acked-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
