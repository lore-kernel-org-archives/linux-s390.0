Return-path: <ath10k-bounces+kvalo=adurom.com@lists.infradead.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/10] use safer test on the result of find_first_zero_bit
Date: Wed,  4 Jun 2014 11:07:50 +0200
Message-Id: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+kvalo=adurom.com@lists.infradead.org
List-Archive: <https://lore.kernel.org/ath10k/>
To: linux-rdma@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-scsi@vger.kernel.org, iss_storagedev@hp.com, linux-sh@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, ath10k@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
return a larger number than the maximum position argument if that position
is not a multiple of BITS_PER_LONG.


_______________________________________________
ath10k mailing list
ath10k@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/ath10k
