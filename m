From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/4] qeth: remove non-recover-thread checkings
Date: Mon, 27 Oct 2008 14:52:10 -0400
Message-ID: <49060DDA.2050308@pobox.com>
References: <20081024091651.603673000@de.ibm.com> <20081024091730.972078000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20081024091730.972078000@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: frank.blaschka@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

frank.blaschka@de.ibm.com wrote:
> From: Ursula Braun <ursula.braun@de.ibm.com>
> 
> IP-threads have been removed from the qeth driver. Only the
> recover-thread is left over. This makes checkings for
> non-recover threads superfluous.
> 
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> ---
> 
>  drivers/s390/net/qeth_l2_main.c |   14 +-------------
>  drivers/s390/net/qeth_l3_main.c |   13 +------------
>  2 files changed, 2 insertions(+), 25 deletions(-)

applied 1-4
